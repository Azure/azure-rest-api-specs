import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.RecoveryServices;

/**
 * Value indicating whether the health error is customer resolvable.
 */
union HealthErrorCustomerResolvability {
  string,

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * The migration status.
 */
union MigrationState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * EnableMigrationInProgress
   */
  EnableMigrationInProgress: "EnableMigrationInProgress",

  /**
   * EnableMigrationFailed
   */
  EnableMigrationFailed: "EnableMigrationFailed",

  /**
   * DisableMigrationInProgress
   */
  DisableMigrationInProgress: "DisableMigrationInProgress",

  /**
   * DisableMigrationFailed
   */
  DisableMigrationFailed: "DisableMigrationFailed",

  /**
   * InitialSeedingInProgress
   */
  InitialSeedingInProgress: "InitialSeedingInProgress",

  /**
   * InitialSeedingFailed
   */
  InitialSeedingFailed: "InitialSeedingFailed",

  /**
   * Replicating
   */
  Replicating: "Replicating",

  /**
   * MigrationInProgress
   */
  MigrationInProgress: "MigrationInProgress",

  /**
   * MigrationSucceeded
   */
  MigrationSucceeded: "MigrationSucceeded",

  /**
   * MigrationFailed
   */
  MigrationFailed: "MigrationFailed",

  /**
   * ResumeInProgress
   */
  ResumeInProgress: "ResumeInProgress",

  /**
   * ResumeInitiated
   */
  ResumeInitiated: "ResumeInitiated",

  /**
   * SuspendingProtection
   */
  SuspendingProtection: "SuspendingProtection",

  /**
   * ProtectionSuspended
   */
  ProtectionSuspended: "ProtectionSuspended",

  /**
   * MigrationCompletedWithInformation
   */
  MigrationCompletedWithInformation: "MigrationCompletedWithInformation",

  /**
   * MigrationPartiallySucceeded
   */
  MigrationPartiallySucceeded: "MigrationPartiallySucceeded",
}

/**
 * The test migrate state.
 */
union TestMigrationState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * TestMigrationInProgress
   */
  TestMigrationInProgress: "TestMigrationInProgress",

  /**
   * TestMigrationSucceeded
   */
  TestMigrationSucceeded: "TestMigrationSucceeded",

  /**
   * TestMigrationFailed
   */
  TestMigrationFailed: "TestMigrationFailed",

  /**
   * TestMigrationCleanupInProgress
   */
  TestMigrationCleanupInProgress: "TestMigrationCleanupInProgress",

  /**
   * TestMigrationCompletedWithInformation
   */
  TestMigrationCompletedWithInformation: "TestMigrationCompletedWithInformation",

  /**
   * TestMigrationPartiallySucceeded
   */
  TestMigrationPartiallySucceeded: "TestMigrationPartiallySucceeded",
}

/**
 * The health.
 */
union ProtectionHealth {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Normal
   */
  Normal: "Normal",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Critical
   */
  Critical: "Critical",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MigrationItemOperation {
  string,

  /**
   * DisableMigration
   */
  DisableMigration: "DisableMigration",

  /**
   * TestMigrate
   */
  TestMigrate: "TestMigrate",

  /**
   * TestMigrateCleanup
   */
  TestMigrateCleanup: "TestMigrateCleanup",

  /**
   * Migrate
   */
  Migrate: "Migrate",

  /**
   * StartResync
   */
  StartResync: "StartResync",

  /**
   * PauseReplication
   */
  PauseReplication: "PauseReplication",

  /**
   * ResumeReplication
   */
  ResumeReplication: "ResumeReplication",
}

/**
 * The recovery point type.
 */
union MigrationRecoveryPointType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * ApplicationConsistent
   */
  ApplicationConsistent: "ApplicationConsistent",

  /**
   * CrashConsistent
   */
  CrashConsistent: "CrashConsistent",
}

/**
 * License type.
 */
union LicenseType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * NoLicenseType
   */
  NoLicenseType: "NoLicenseType",

  /**
   * WindowsServer
   */
  WindowsServer: "WindowsServer",
}

/**
 * Disable protection reason. It can have values NotSpecified/MigrationComplete.
 */
union DisableProtectionReason {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * MigrationComplete
   */
  MigrationComplete: "MigrationComplete",
}

/**
 * The recovery point type.
 */
union ClusterRecoveryPointType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * ApplicationConsistent
   */
  ApplicationConsistent: "ApplicationConsistent",

  /**
   * CrashConsistent
   */
  CrashConsistent: "CrashConsistent",
}

/**
 * Failover direction.
 */
union FailoverDirection {
  string,

  /**
   * PrimaryToRecovery
   */
  PrimaryToRecovery: "PrimaryToRecovery",

  /**
   * RecoveryToPrimary
   */
  RecoveryToPrimary: "RecoveryToPrimary",
}

/**
 * A value indicating whether security update required.
 */
union AgentVersionStatus {
  string,

  /**
   * Supported
   */
  Supported: "Supported",

  /**
   * NotSupported
   */
  NotSupported: "NotSupported",

  /**
   * Deprecated
   */
  Deprecated: "Deprecated",

  /**
   * UpdateRequired
   */
  UpdateRequired: "UpdateRequired",

  /**
   * SecurityUpdateRequired
   */
  SecurityUpdateRequired: "SecurityUpdateRequired",
}

/**
 * The output type of the jobs.
 */
union ExportJobOutputSerializationType {
  string,

  /**
   * Json
   */
  Json: "Json",

  /**
   * Xml
   */
  Xml: "Xml",

  /**
   * Excel
   */
  Excel: "Excel",
}

/**
 * The group type.
 */
union RecoveryPlanGroupType {
  string,

  /**
   * Shutdown
   */
  Shutdown: "Shutdown",

  /**
   * Boot
   */
  Boot: "Boot",

  /**
   * Failover
   */
  Failover: "Failover",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ReplicationProtectedItemOperation {
  string,

  /**
   * ReverseReplicate
   */
  ReverseReplicate: "ReverseReplicate",

  /**
   * Commit
   */
  Commit: "Commit",

  /**
   * PlannedFailover
   */
  PlannedFailover: "PlannedFailover",

  /**
   * UnplannedFailover
   */
  UnplannedFailover: "UnplannedFailover",

  /**
   * DisableProtection
   */
  DisableProtection: "DisableProtection",

  /**
   * TestFailover
   */
  TestFailover: "TestFailover",

  /**
   * TestFailoverCleanup
   */
  TestFailoverCleanup: "TestFailoverCleanup",

  /**
   * Failback
   */
  Failback: "Failback",

  /**
   * FinalizeFailback
   */
  FinalizeFailback: "FinalizeFailback",

  /**
   * CancelFailover
   */
  CancelFailover: "CancelFailover",

  /**
   * ChangePit
   */
  ChangePit: "ChangePit",

  /**
   * RepairReplication
   */
  RepairReplication: "RepairReplication",

  /**
   * SwitchProtection
   */
  SwitchProtection: "SwitchProtection",

  /**
   * CompleteMigration
   */
  CompleteMigration: "CompleteMigration",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PossibleOperationsDirections {
  string,

  /**
   * PrimaryToRecovery
   */
  PrimaryToRecovery: "PrimaryToRecovery",

  /**
   * RecoveryToPrimary
   */
  RecoveryToPrimary: "RecoveryToPrimary",
}

/**
 * The failover deployment model.
 */
union FailoverDeploymentModel {
  string,

  /**
   * NotApplicable
   */
  NotApplicable: "NotApplicable",

  /**
   * Classic
   */
  Classic: "Classic",

  /**
   * ResourceManager
   */
  ResourceManager: "ResourceManager",
}

/**
 * A value indicating whether source site operations are required.
 */
union SourceSiteOperations {
  string,

  /**
   * Required
   */
  Required: "Required",

  /**
   * NotRequired
   */
  NotRequired: "NotRequired",
}

/**
 * The category of the health error.
 */
union HealthErrorCategory {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Replication
   */
  Replication: "Replication",

  /**
   * TestFailover
   */
  TestFailover: "TestFailover",

  /**
   * Configuration
   */
  Configuration: "Configuration",

  /**
   * FabricInfrastructure
   */
  FabricInfrastructure: "FabricInfrastructure",

  /**
   * VersionExpiry
   */
  VersionExpiry: "VersionExpiry",

  /**
   * AgentAutoUpdateInfra
   */
  AgentAutoUpdateInfra: "AgentAutoUpdateInfra",

  /**
   * AgentAutoUpdateArtifactDeleted
   */
  AgentAutoUpdateArtifactDeleted: "AgentAutoUpdateArtifactDeleted",

  /**
   * AgentAutoUpdateRunAsAccount
   */
  AgentAutoUpdateRunAsAccount: "AgentAutoUpdateRunAsAccount",

  /**
   * AgentAutoUpdateRunAsAccountExpiry
   */
  AgentAutoUpdateRunAsAccountExpiry: "AgentAutoUpdateRunAsAccountExpiry",

  /**
   * AgentAutoUpdateRunAsAccountExpired
   */
  AgentAutoUpdateRunAsAccountExpired: "AgentAutoUpdateRunAsAccountExpired",
}

/**
 * Severity of error.
 */
union Severity {
  string,

  /**
   * NONE
   */
  NONE: "NONE",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Info
   */
  Info: "Info",
}

/**
 * A value indicating whether the recovery point is multi VM consistent.
 */
union RecoveryPointSyncType {
  string,

  /**
   * MultiVmSyncRecoveryPoint
   */
  MultiVmSyncRecoveryPoint: "MultiVmSyncRecoveryPoint",

  /**
   * PerVmRecoveryPoint
   */
  PerVmRecoveryPoint: "PerVmRecoveryPoint",
}

/**
 * A value indicating whether the auto update is enabled.
 */
union AgentAutoUpdateStatus {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * A value indicating the type authentication to use for automation Account.
 */
union AutomationAccountAuthenticationType {
  string,

  /**
   * RunAsAccount
   */
  RunAsAccount: "RunAsAccount",

  /**
   * SystemAssignedIdentity
   */
  SystemAssignedIdentity: "SystemAssignedIdentity",
}

/**
 * The recovery availability type of the virtual machine.
 */
union A2ARecoveryAvailabilityType {
  string,

  /**
   * Single
   */
  Single: "Single",

  /**
   * AvailabilitySet
   */
  AvailabilitySet: "AvailabilitySet",

  /**
   * AvailabilityZone
   */
  AvailabilityZone: "AvailabilityZone",
}

/**
 * A value indicating whether the auto protection is enabled.
 */
union AutoProtectionOfDataDisk {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The extended location type.
 */
union ExtendedLocationType {
  string,

  /**
   * EdgeZone
   */
  EdgeZone: "EdgeZone",
}

/**
 * A value indicating whether multi-VM sync has to be enabled. Value should be 'Enabled' or 'Disabled'.
 */
union SetMultiVmSyncStatus {
  string,

  /**
   * Enable
   */
  Enable: "Enable",

  /**
   * Disable
   */
  Disable: "Disable",
}

/**
 * Whether Multi VM group is auto created or specified by user.
 */
union MultiVmGroupCreateOption {
  string,

  /**
   * AutoCreated
   */
  AutoCreated: "AutoCreated",

  /**
   * UserSpecified
   */
  UserSpecified: "UserSpecified",
}

/**
 * The encryption type of the VM.
 */
union VmEncryptionType {
  string,

  /**
   * NotEncrypted
   */
  NotEncrypted: "NotEncrypted",

  /**
   * OnePassEncrypted
   */
  OnePassEncrypted: "OnePassEncrypted",

  /**
   * TwoPassEncrypted
   */
  TwoPassEncrypted: "TwoPassEncrypted",
}

/**
 * A value indicating the churn option selected by user.
 */
union ChurnOptionSelected {
  string,

  /**
   * Normal
   */
  Normal: "Normal",

  /**
   * High
   */
  High: "High",
}

/**
 * The disk type.
 */
union DiskAccountType {
  string,

  /**
   * Standard_LRS
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Premium_LRS
   */
  Premium_LRS: "Premium_LRS",

  /**
   * StandardSSD_LRS
   */
  StandardSSD_LRS: "StandardSSD_LRS",

  /**
   * PremiumV2_LRS
   */
  PremiumV2_LRS: "PremiumV2_LRS",

  /**
   * UltraSSD_LRS
   */
  UltraSSD_LRS: "UltraSSD_LRS",

  /**
   * StandardSSD_ZRS
   */
  StandardSSD_ZRS: "StandardSSD_ZRS",

  /**
   * Premium_ZRS
   */
  Premium_ZRS: "Premium_ZRS",
}

/**
 * The SQL Server license type.
 */
union SqlServerLicenseType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * NoLicenseType
   */
  NoLicenseType: "NoLicenseType",

  /**
   * PAYG
   */
  PAYG: "PAYG",

  /**
   * AHUB
   */
  AHUB: "AHUB",
}

/**
 * The license type for Linux VM's.
 */
union LinuxLicenseType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * NoLicenseType
   */
  NoLicenseType: "NoLicenseType",

  /**
   * LinuxServer
   */
  LinuxServer: "LinuxServer",
}

/**
 * The target VM security type.
 */
union SecurityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * TrustedLaunch
   */
  TrustedLaunch: "TrustedLaunch",

  /**
   * ConfidentialVM
   */
  ConfidentialVM: "ConfidentialVM",
}

/**
 * Security configuration state.
 */
union SecurityConfiguration {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * A value indicating whether the VM has a physical disk attached. String value of SrsDataContract.PresenceStatus enum.
 */
union PresenceStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Present
   */
  Present: "Present",

  /**
   * NotPresent
   */
  NotPresent: "NotPresent",
}

/**
 * The throughput status.
 */
union RcmComponentStatus {
  string,

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Critical
   */
  Critical: "Critical",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AgentUpgradeBlockedReason {
  string,

  /**
   * AlreadyOnLatestVersion
   */
  AlreadyOnLatestVersion: "AlreadyOnLatestVersion",

  /**
   * RebootRequired
   */
  RebootRequired: "RebootRequired",

  /**
   * AgentNoHeartbeat
   */
  AgentNoHeartbeat: "AgentNoHeartbeat",

  /**
   * RcmProxyNoHeartbeat
   */
  RcmProxyNoHeartbeat: "RcmProxyNoHeartbeat",

  /**
   * ProcessServerNoHeartbeat
   */
  ProcessServerNoHeartbeat: "ProcessServerNoHeartbeat",

  /**
   * IncompatibleApplianceVersion
   */
  IncompatibleApplianceVersion: "IncompatibleApplianceVersion",

  /**
   * NotProtected
   */
  NotProtected: "NotProtected",

  /**
   * UnsupportedProtectionScenario
   */
  UnsupportedProtectionScenario: "UnsupportedProtectionScenario",

  /**
   * DistroIsNotReported
   */
  DistroIsNotReported: "DistroIsNotReported",

  /**
   * DistroNotSupportedForUpgrade
   */
  DistroNotSupportedForUpgrade: "DistroNotSupportedForUpgrade",

  /**
   * MissingUpgradePath
   */
  MissingUpgradePath: "MissingUpgradePath",

  /**
   * InvalidAgentVersion
   */
  InvalidAgentVersion: "InvalidAgentVersion",

  /**
   * InvalidDriverVersion
   */
  InvalidDriverVersion: "InvalidDriverVersion",

  /**
   * ReInstallRequired
   */
  ReInstallRequired: "ReInstallRequired",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The recovery point type.
 */
union InMageRcmFailbackRecoveryPointType {
  string,

  /**
   * ApplicationConsistent
   */
  ApplicationConsistent: "ApplicationConsistent",

  /**
   * CrashConsistent
   */
  CrashConsistent: "CrashConsistent",
}

/**
 * The progress health.
 */
union DiskReplicationProgressHealth {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * SlowProgress
   */
  SlowProgress: "SlowProgress",

  /**
   * NoProgress
   */
  NoProgress: "NoProgress",

  /**
   * Queued
   */
  Queued: "Queued",
}

/**
 * The initial replication progress health.
 */
union VmReplicationProgressHealth {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * SlowProgress
   */
  SlowProgress: "SlowProgress",

  /**
   * NoProgress
   */
  NoProgress: "NoProgress",
}

/**
 * The resync state.
 */
union ResyncState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * PreparedForResynchronization
   */
  PreparedForResynchronization: "PreparedForResynchronization",

  /**
   * StartedResynchronization
   */
  StartedResynchronization: "StartedResynchronization",
}

/**
 * The last planned failover status.
 */
union PlannedFailoverStatus {
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
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MobilityAgentReinstallType {
  string,

  /**
   * UserTriggered
   */
  UserTriggered: "UserTriggered",

  /**
   * AutoTriggered
   */
  AutoTriggered: "AutoTriggered",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AgentReinstallBlockedReason {
  string,

  /**
   * DistroNotSupported
   */
  DistroNotSupported: "DistroNotSupported",

  /**
   * AgentNoHeartbeat
   */
  AgentNoHeartbeat: "AgentNoHeartbeat",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The source IP address type.
 */
union EthernetAddressType {
  string,

  /**
   * Dynamic
   */
  Dynamic: "Dynamic",

  /**
   * Static
   */
  Static: "Static",
}

/**
 * The disk state.
 */
union DiskState {
  string,

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",

  /**
   * InitialReplicationPending
   */
  InitialReplicationPending: "InitialReplicationPending",

  /**
   * InitialReplicationFailed
   */
  InitialReplicationFailed: "InitialReplicationFailed",

  /**
   * Protected
   */
  Protected: "Protected",
}

/**
 * The agent auto upgrade state.
 */
union MobilityAgentUpgradeState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Started
   */
  Started: "Started",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Commit
   */
  Commit: "Commit",
}

/**
 * The recovery point type. Values from LatestTime, LatestTag or Custom. In the case of custom, the recovery point provided by RecoveryPointId will be used. In the other two cases, recovery point id will be ignored.
 */
union RecoveryPointType {
  string,

  /**
   * LatestTime
   */
  LatestTime: "LatestTime",

  /**
   * LatestTag
   */
  LatestTag: "LatestTag",

  /**
   * Custom
   */
  Custom: "Custom",
}

/**
 * The recovery point type.
 */
union A2ARpRecoveryPointType {
  string,

  /**
   * Latest
   */
  Latest: "Latest",

  /**
   * LatestApplicationConsistent
   */
  LatestApplicationConsistent: "LatestApplicationConsistent",

  /**
   * LatestCrashConsistent
   */
  LatestCrashConsistent: "LatestCrashConsistent",

  /**
   * LatestProcessed
   */
  LatestProcessed: "LatestProcessed",
}

/**
 * A value indicating whether multi VM sync enabled VMs should use multi VM sync points for failover.
 */
union MultiVmSyncPointOption {
  string,

  /**
   * UseMultiVmSyncRecoveryPoint
   */
  UseMultiVmSyncRecoveryPoint: "UseMultiVmSyncRecoveryPoint",

  /**
   * UsePerVmRecoveryPoint
   */
  UsePerVmRecoveryPoint: "UsePerVmRecoveryPoint",
}

/**
 * The fabric location.
 */
union RecoveryPlanActionLocation {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Recovery
   */
  Recovery: "Recovery",
}

/**
 * The data sync option.
 */
union DataSyncStatus {
  string,

  /**
   * ForDownTime
   */
  ForDownTime: "ForDownTime",

  /**
   * ForSynchronization
   */
  ForSynchronization: "ForSynchronization",
}

/**
 * The ALR option.
 */
union AlternateLocationRecoveryOption {
  string,

  /**
   * CreateVmIfNotFound
   */
  CreateVmIfNotFound: "CreateVmIfNotFound",

  /**
   * NoAction
   */
  NoAction: "NoAction",
}

/**
 * The recovery point type.
 */
union HyperVReplicaAzureRpRecoveryPointType {
  string,

  /**
   * Latest
   */
  Latest: "Latest",

  /**
   * LatestApplicationConsistent
   */
  LatestApplicationConsistent: "LatestApplicationConsistent",

  /**
   * LatestProcessed
   */
  LatestProcessed: "LatestProcessed",
}

/**
 * The recovery point type.
 */
union InMageV2RpRecoveryPointType {
  string,

  /**
   * Latest
   */
  Latest: "Latest",

  /**
   * LatestApplicationConsistent
   */
  LatestApplicationConsistent: "LatestApplicationConsistent",

  /**
   * LatestCrashConsistent
   */
  LatestCrashConsistent: "LatestCrashConsistent",

  /**
   * LatestProcessed
   */
  LatestProcessed: "LatestProcessed",
}

/**
 * The recovery point type.
 */
union RpInMageRecoveryPointType {
  string,

  /**
   * LatestTime
   */
  LatestTime: "LatestTime",

  /**
   * LatestTag
   */
  LatestTag: "LatestTag",

  /**
   * Custom
   */
  Custom: "Custom",
}

/**
 * The recovery point type.
 */
union RecoveryPlanPointType {
  string,

  /**
   * Latest
   */
  Latest: "Latest",

  /**
   * LatestApplicationConsistent
   */
  LatestApplicationConsistent: "LatestApplicationConsistent",

  /**
   * LatestCrashConsistent
   */
  LatestCrashConsistent: "LatestCrashConsistent",

  /**
   * LatestProcessed
   */
  LatestProcessed: "LatestProcessed",
}

/**
 * Collection of ClientDiscovery details.
 */
model OperationsDiscoveryCollection is Azure.Core.Page<OperationsDiscovery>;

/**
 * Operations discovery class.
 */
model OperationsDiscovery {
  /**
   * Name of the API. The name of the operation being performed on this particular object. It should match the action name that appears in RBAC / the event service. Examples of operations include: * Microsoft.Compute/virtualMachine/capture/action * Microsoft.Compute/virtualMachine/restart/action * Microsoft.Compute/virtualMachine/write * Microsoft.Compute/virtualMachine/read * Microsoft.Compute/virtualMachine/delete Each action should include, in order: (1) Resource Provider Namespace (2) Type hierarchy for which the action applies (e.g. server/databases for a SQL Azure database) (3) Read, Write, Action or Delete indicating which type applies. If it is a PUT/PATCH on a collection or named value, Write should be used. If it is a GET, Read should be used. If it is a DELETE, Delete should be used. If it is a POST, Action should be used. As a note: all resource providers would need to include the "{Resource Provider Namespace}/register/action" operation in their response. This API is used to register for their service, and should include details about the operation (e.g. a localized name for the resource provider + any special considerations like PII release).
   */
  name?: string;

  /**
   * Object type.
   */
  display?: Display;

  /**
   * Origin. The intended executor of the operation; governs the display of the operation in the RBAC UX and the audit logs UX. Default value is "user,system".
   */
  origin?: string;

  /**
   * Properties. Reserved for future use.
   */
  properties?: OperationsDiscoveryProperties;
}

/**
 * ClientDiscovery properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationsDiscoveryProperties {}

/**
 * Contains the localized display information for this particular operation / action. These value will be used by several clients for (1) custom role definitions for RBAC; (2) complex query filters for the event service; and (3) audit history / records for management operations.
 */
model Display {
  /**
   * The provider. The localized friendly form of the resource provider name - it is expected to also include the publisher/company responsible. It should use Title Casing and begin with "Microsoft" for 1st party services. e.g. "Microsoft Monitoring Insights" or "Microsoft Compute.".
   */
  provider?: string;

  /**
   * The resource. The localized friendly form of the resource related to this action/operation - it should match the public documentation for the resource provider. It should use Title Casing. This value should be unique for a particular URL type (e.g. nested types should *not* reuse their parent's display.resource field). e.g. "Virtual Machines" or "Scheduler Job Collections", or "Virtual Machine VM Sizes" or "Scheduler Jobs".
   */
  resource?: string;

  /**
   * The operation. The localized friendly name for the operation, as it should be shown to the user. It should be concise (to fit in drop downs) but clear (i.e. self-documenting). It should use Title Casing. Prescriptive guidance: Read Create or Update Delete 'ActionName'.
   */
  operation?: string;

  /**
   * The description. The localized friendly description for the operation, as it should be shown to the user. It should be thorough, yet concise - it will be used in tool tips and detailed views. Prescriptive guidance for namespaces: Read any 'display.provider' resource Create or Update any 'display.provider' resource Delete any 'display.provider' resource Perform any other action on any 'display.provider' resource Prescriptive guidance for namespaces: Read any 'display.resource' Create or Update any 'display.resource' Delete any 'display.resource' 'ActionName' any 'display.resources'.
   */
  description?: string;
}

/**
 * Collection of alerts.
 */
model AlertCollection is Azure.Core.Page<Alert>;

/**
 * The properties of an alert.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertProperties {
  /**
   * A value indicating whether to send email to subscription administrator.
   */
  sendToOwners?: string;

  /**
   * The custom email address for sending emails.
   */
  customEmailAddresses?: string[];

  /**
   * The locale for the email notification.
   */
  locale?: string;
}

/**
 * Azure resource.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource Name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource Type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource Location
   */
  location?: string;
}

/**
 * Request to configure alerts for the system.
 */
model ConfigureAlertRequest {
  /**
   * The properties of a configure alert request.
   */
  properties?: ConfigureAlertRequestProperties;
}

/**
 * Properties of a configure alert request.
 */
model ConfigureAlertRequestProperties {
  /**
   * A value indicating whether to send email to subscription administrator.
   */
  sendToOwners?: string;

  /**
   * The custom email address for sending emails.
   */
  customEmailAddresses?: string[];

  /**
   * The locale for the email notification.
   */
  locale?: string;
}

/**
 * Collection of appliance details.
 */
model ApplianceCollection is Azure.Core.Page<ReplicationAppliance>;

/**
 * Replication appliance definition.
 */
model ReplicationAppliance {
  /**
   * Appliance related data.
   */
  properties?: ReplicationApplianceProperties;
}

/**
 * Replication appliance properties.
 */
model ReplicationApplianceProperties {
  /**
   * Provider specific settings.
   */
  providerSpecificDetails?: ApplianceSpecificDetails;
}

/**
 * Appliance specific details.
 */
@discriminator("instanceType")
model ApplianceSpecificDetails {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Replication eligibility results collection response model.
 */
model ReplicationEligibilityResultsCollection {
  /**
   * The replication eligibility results details.
   */
  @pageItems
  value?: ReplicationEligibilityResults[];
}

/**
 * Properties model for replication eligibility results API.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReplicationEligibilityResultsProperties {
  /**
   * The client request Id.
   */
  @visibility(Lifecycle.Read)
  clientRequestId?: string;

  /**
   * The error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errors?: ReplicationEligibilityResultsErrorInfo[];
}

/**
 * Error model that can be exposed to the user.
 */
model ReplicationEligibilityResultsErrorInfo {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;

  /**
   * The possible causes.
   */
  possibleCauses?: string;

  /**
   * The recommended action.
   */
  recommendedAction?: string;

  /**
   * The error status.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Collection of fabric details.
 */
model EventCollection is Azure.Core.Page<Event>;

/**
 * The properties of a monitoring event.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventProperties {
  /**
   * The Id of the monitoring event.
   */
  eventCode?: string;

  /**
   * The event name.
   */
  description?: string;

  /**
   * The type of the event. for example: VM Health, Server Health, Job Failure etc.
   */
  eventType?: string;

  /**
   * The friendly name of the source of the event on which it is raised (for example, VM, VMM etc).
   */
  affectedObjectFriendlyName?: string;

  /**
   * The affected object correlationId for the event.
   */
  affectedObjectCorrelationId?: string;

  /**
   * The severity of the event.
   */
  severity?: string;

  /**
   * The time of occurrence of the event.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeOfOccurrence?: utcDateTime;

  /**
   * The ARM ID of the fabric.
   */
  fabricId?: string;

  /**
   * The provider specific settings.
   */
  providerSpecificDetails?: EventProviderSpecificDetails;

  /**
   * The event specific settings.
   */
  eventSpecificDetails?: EventSpecificDetails;

  /**
   * The list of errors / warnings capturing details associated with the issue(s).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrors?: HealthError[];
}

/**
 * Model class for provider specific details for an event.
 */
@discriminator("instanceType")
model EventProviderSpecificDetails {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Model class for event specific details for an event.
 */
@discriminator("instanceType")
model EventSpecificDetails {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Health Error.
 */
model HealthError {
  /**
   * The inner health errors. HealthError having a list of HealthError as child errors is problematic. InnerHealthError is used because this will prevent an infinite loop of structures when Hydra tries to auto-generate the contract. We are exposing the related health errors as inner health errors and all API consumers can utilize this in the same fashion as Exception -&gt; InnerException.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  innerHealthErrors?: InnerHealthError[];

  /**
   * Source of error.
   */
  errorSource?: string;

  /**
   * Type of error.
   */
  errorType?: string;

  /**
   * Level of error.
   */
  errorLevel?: string;

  /**
   * Category of error.
   */
  errorCategory?: string;

  /**
   * Error code.
   */
  errorCode?: string;

  /**
   * Summary message of the entity.
   */
  summaryMessage?: string;

  /**
   * Error message.
   */
  errorMessage?: string;

  /**
   * Possible causes of error.
   */
  possibleCauses?: string;

  /**
   * Recommended action to resolve error.
   */
  recommendedAction?: string;

  /**
   * Error creation time (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeUtc?: utcDateTime;

  /**
   * DRA error message.
   */
  recoveryProviderErrorMessage?: string;

  /**
   * ID of the entity.
   */
  entityId?: string;

  /**
   * The health error unique id.
   */
  errorId?: string;

  /**
   * Value indicating whether the health error is customer resolvable.
   */
  customerResolvability?: HealthErrorCustomerResolvability;
}

/**
 * Implements InnerHealthError class. HealthError object has a list of InnerHealthErrors as child errors. InnerHealthError is used because this will prevent an infinite loop of structures when Hydra tries to auto-generate the contract. We are exposing the related health errors as inner health errors and all API consumers can utilize this in the same fashion as Exception -&gt; InnerException.
 */
model InnerHealthError {
  /**
   * Source of error.
   */
  errorSource?: string;

  /**
   * Type of error.
   */
  errorType?: string;

  /**
   * Level of error.
   */
  errorLevel?: string;

  /**
   * Category of error.
   */
  errorCategory?: string;

  /**
   * Error code.
   */
  errorCode?: string;

  /**
   * Summary message of the entity.
   */
  summaryMessage?: string;

  /**
   * Error message.
   */
  errorMessage?: string;

  /**
   * Possible causes of error.
   */
  possibleCauses?: string;

  /**
   * Recommended action to resolve error.
   */
  recommendedAction?: string;

  /**
   * Error creation time (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeUtc?: utcDateTime;

  /**
   * DRA error message.
   */
  recoveryProviderErrorMessage?: string;

  /**
   * ID of the entity.
   */
  entityId?: string;

  /**
   * The health error unique id.
   */
  errorId?: string;

  /**
   * Value indicating whether the health error is customer resolvable.
   */
  customerResolvability?: HealthErrorCustomerResolvability;
}

/**
 * Collection of fabric details.
 */
model FabricCollection is Azure.Core.Page<Fabric>;

/**
 * Fabric properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FabricProperties {
  /**
   * Friendly name of the fabric.
   */
  friendlyName?: string;

  /**
   * Encryption details for the fabric.
   */
  encryptionDetails?: EncryptionDetails;

  /**
   * Rollover encryption details for the fabric.
   */
  rolloverEncryptionDetails?: EncryptionDetails;

  /**
   * Dra Registration Id.
   */
  internalIdentifier?: string;

  /**
   * BCDR state of the fabric.
   */
  bcdrState?: string;

  /**
   * Fabric specific settings.
   */
  customDetails?: FabricSpecificDetails;

  /**
   * Fabric health error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrorDetails?: HealthError[];

  /**
   * Health of fabric.
   */
  health?: string;
}

/**
 * Encryption details for the fabric.
 */
model EncryptionDetails {
  /**
   * The key encryption key state for the Vmm.
   */
  kekState?: string;

  /**
   * The key encryption key certificate thumbprint.
   */
  kekCertThumbprint?: string;

  /**
   * The key encryption key certificate expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  kekCertExpiryDate?: utcDateTime;
}

/**
 * Fabric specific details.
 */
@discriminator("instanceType")
model FabricSpecificDetails {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Site details provided during the time of site creation.
 */
model FabricCreationInput {
  /**
   * Fabric creation input.
   */
  properties?: FabricCreationInputProperties;
}

/**
 * Properties of site details provided during the time of site creation.
 */
model FabricCreationInputProperties {
  /**
   * Fabric provider specific creation input.
   */
  customDetails?: FabricSpecificCreationInput;
}

/**
 * Fabric provider specific settings.
 */
@discriminator("instanceType")
model FabricSpecificCreationInput {
  /**
   * Gets the class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Request to failover a process server.
 */
model FailoverProcessServerRequest {
  /**
   * The properties of the PS Failover request.
   */
  properties?: FailoverProcessServerRequestProperties;
}

/**
 * The properties of the Failover Process Server request.
 */
model FailoverProcessServerRequestProperties {
  /**
   * The container identifier.
   */
  containerName?: string;

  /**
   * The source process server.
   */
  sourceProcessServerId?: string;

  /**
   * The new process server.
   */
  targetProcessServerId?: string;

  /**
   * The VMS to migrate.
   */
  vmsToMigrate?: string[];

  /**
   * A value for failover type. It can be systemlevel/serverlevel.
   */
  updateType?: string;
}

/**
 * Certificate renewal input.
 */
model RenewCertificateInput {
  /**
   * Renew certificate input properties.
   */
  properties?: RenewCertificateInputProperties;
}

/**
 * Renew Certificate input properties.
 */
model RenewCertificateInputProperties {
  /**
   * Renew certificate type.
   */
  renewCertificateType?: string;
}

/**
 * List of logical networks.
 */
model LogicalNetworkCollection is Azure.Core.Page<LogicalNetwork>;

/**
 * Logical Network Properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LogicalNetworkProperties {
  /**
   * The Friendly Name.
   */
  friendlyName?: string;

  /**
   * A value indicating whether Network Virtualization is enabled for the logical network.
   */
  networkVirtualizationStatus?: string;

  /**
   * A value indicating whether logical network is used as private test network by test failover.
   */
  logicalNetworkUsage?: string;

  /**
   * A value indicating whether logical network definitions are isolated.
   */
  logicalNetworkDefinitionsStatus?: string;
}

/**
 * List of networks.
 */
model NetworkCollection is Azure.Core.Page<Network>;

/**
 * Network Properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkProperties {
  /**
   * The Fabric Type.
   */
  fabricType?: string;

  /**
   * The List of subnets.
   */
  subnets?: Subnet[];

  /**
   * The Friendly Name.
   */
  friendlyName?: string;

  /**
   * The Network Type.
   */
  networkType?: string;
}

/**
 * Subnets of the network.
 */
model Subnet {
  /**
   * The subnet name.
   */
  name?: string;

  /**
   * The subnet friendly name.
   */
  friendlyName?: string;

  /**
   * The list of addresses for the subnet.
   */
  addressList?: string[];
}

/**
 * List of network mappings. As with NetworkMapping, it should be possible to reuse a prev version of this class. It doesn't seem likely this class could be anything more than a slightly bespoke collection of NetworkMapping. Hence it makes sense to override Load with Base.NetworkMapping instead of existing CurrentVersion.NetworkMapping.
 */
model NetworkMappingCollection is Azure.Core.Page<NetworkMapping>;

/**
 * Network Mapping Properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkMappingProperties {
  /**
   * The pairing state for network mapping.
   */
  state?: string;

  /**
   * The primary network friendly name.
   */
  primaryNetworkFriendlyName?: string;

  /**
   * The primary network id for network mapping.
   */
  primaryNetworkId?: string;

  /**
   * The primary fabric friendly name.
   */
  primaryFabricFriendlyName?: string;

  /**
   * The recovery network friendly name.
   */
  recoveryNetworkFriendlyName?: string;

  /**
   * The recovery network id for network mapping.
   */
  recoveryNetworkId?: string;

  /**
   * The recovery fabric ARM id.
   */
  recoveryFabricArmId?: string;

  /**
   * The recovery fabric friendly name.
   */
  recoveryFabricFriendlyName?: string;

  /**
   * The fabric specific settings.
   */
  fabricSpecificSettings?: NetworkMappingFabricSpecificSettings;
}

/**
 * Network Mapping fabric specific settings.
 */
@discriminator("instanceType")
model NetworkMappingFabricSpecificSettings {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Create network mappings input.
 */
model CreateNetworkMappingInput {
  /**
   * Input properties for creating network mapping.
   */
  properties: CreateNetworkMappingInputProperties;
}

/**
 * Common input details for network mapping operation.
 */
model CreateNetworkMappingInputProperties {
  /**
   * Recovery fabric Name.
   */
  recoveryFabricName?: string;

  /**
   * Recovery network Id.
   */
  recoveryNetworkId: string;

  /**
   * Fabric specific input properties.
   */
  fabricSpecificDetails?: FabricSpecificCreateNetworkMappingInput;
}

/**
 * Input details specific to fabrics during Network Mapping.
 */
@discriminator("instanceType")
model FabricSpecificCreateNetworkMappingInput {
  /**
   * The instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Update network mapping input.
 */
model UpdateNetworkMappingInput {
  /**
   * The input properties needed to update network mapping.
   */
  properties?: UpdateNetworkMappingInputProperties;
}

/**
 * Common input details for network mapping operation.
 */
model UpdateNetworkMappingInputProperties {
  /**
   * Recovery fabric name.
   */
  recoveryFabricName?: string;

  /**
   * Recovery network Id.
   */
  recoveryNetworkId?: string;

  /**
   * Fabrics specific input network Id.
   */
  fabricSpecificDetails?: FabricSpecificUpdateNetworkMappingInput;
}

/**
 * Input details specific to fabrics during Network Mapping.
 */
@discriminator("instanceType")
model FabricSpecificUpdateNetworkMappingInput {
  /**
   * The instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Protection Container collection.
 */
model ProtectionContainerCollection is Azure.Core.Page<ProtectionContainer>;

/**
 * Protection profile custom data details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectionContainerProperties {
  /**
   * Fabric friendly name.
   */
  fabricFriendlyName?: string;

  /**
   * The name.
   */
  friendlyName?: string;

  /**
   * The fabric type.
   */
  fabricType?: string;

  /**
   * Number of protected PEs.
   */
  protectedItemCount?: int32;

  /**
   * The pairing status of this cloud.
   */
  pairingStatus?: string;

  /**
   * The role of this cloud.
   */
  role?: string;

  /**
   * Fabric specific details.
   */
  fabricSpecificDetails?: ProtectionContainerFabricSpecificDetails;
}

/**
 * Base class for fabric specific details of container.
 */
model ProtectionContainerFabricSpecificDetails {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  @visibility(Lifecycle.Read)
  instanceType?: string;
}

/**
 * Create protection container input.
 */
model CreateProtectionContainerInput {
  /**
   * Create protection container input properties.
   */
  properties?: CreateProtectionContainerInputProperties;
}

/**
 * Create protection container input properties.
 */
model CreateProtectionContainerInputProperties {
  /**
   * Provider specific inputs for container creation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  providerSpecificInput?: ReplicationProviderSpecificContainerCreationInput[];
}

/**
 * Provider specific input for container creation operation.
 */
@discriminator("instanceType")
model ReplicationProviderSpecificContainerCreationInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Request to add a physical machine as a protectable item in a container.
 */
model DiscoverProtectableItemRequest {
  /**
   * The properties of a discover protectable item request.
   */
  properties?: DiscoverProtectableItemRequestProperties;
}

/**
 * Discover protectable item properties.
 */
model DiscoverProtectableItemRequestProperties {
  /**
   * The friendly name of the physical machine.
   */
  friendlyName?: string;

  /**
   * The IP address of the physical machine to be discovered.
   */
  ipAddress?: string;

  /**
   * The OS type on the physical machine.
   */
  osType?: string;
}

/**
 * Migration item collection.
 */
model MigrationItemCollection is Azure.Core.Page<MigrationItem>;

/**
 * Migration item properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrationItemProperties {
  /**
   * The on-premise virtual machine name.
   */
  @visibility(Lifecycle.Read)
  machineName?: string;

  /**
   * The ARM Id of policy governing this item.
   */
  @visibility(Lifecycle.Read)
  policyId?: string;

  /**
   * The name of policy governing this item.
   */
  @visibility(Lifecycle.Read)
  policyFriendlyName?: string;

  /**
   * The recovery services provider ARM Id.
   */
  @visibility(Lifecycle.Read)
  recoveryServicesProviderId?: string;

  /**
   * The replication status.
   */
  @visibility(Lifecycle.Read)
  replicationStatus?: string;

  /**
   * The migration status.
   */
  @visibility(Lifecycle.Read)
  migrationState?: MigrationState;

  /**
   * The migration state description.
   */
  @visibility(Lifecycle.Read)
  migrationStateDescription?: string;

  /**
   * The last test migration time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTestMigrationTime?: utcDateTime;

  /**
   * The status of the last test migration.
   */
  @visibility(Lifecycle.Read)
  lastTestMigrationStatus?: string;

  /**
   * The last migration time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastMigrationTime?: utcDateTime;

  /**
   * The status of the last migration.
   */
  @visibility(Lifecycle.Read)
  lastMigrationStatus?: string;

  /**
   * The test migrate state.
   */
  @visibility(Lifecycle.Read)
  testMigrateState?: TestMigrationState;

  /**
   * The test migrate state description.
   */
  @visibility(Lifecycle.Read)
  testMigrateStateDescription?: string;

  /**
   * The consolidated health.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The list of health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  healthErrors?: HealthError[];

  /**
   * The allowed operations on the migration item based on the current migration state of the item.
   */
  @visibility(Lifecycle.Read)
  allowedOperations?: MigrationItemOperation[];

  /**
   * The current job details.
   */
  @visibility(Lifecycle.Read)
  currentJob?: CurrentJobDetails;

  /**
   * The critical past job details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  criticalJobHistory?: CriticalJobHistoryDetails[];

  /**
   * The correlation Id for events associated with this migration item.
   */
  @visibility(Lifecycle.Read)
  eventCorrelationId?: string;

  /**
   * The migration provider custom settings.
   */
  providerSpecificDetails?: MigrationProviderSpecificSettings;
}

/**
 * Current job details of the migration item.
 */
model CurrentJobDetails {
  /**
   * The job name.
   */
  @visibility(Lifecycle.Read)
  jobName?: string;

  /**
   * The ARM Id of the job being executed.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The start time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

/**
 * Critical past job details of the migration item.
 */
model CriticalJobHistoryDetails {
  /**
   * The job name.
   */
  @visibility(Lifecycle.Read)
  jobName?: string;

  /**
   * The ARM Id of the job being executed.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The start time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The job state.
   */
  @visibility(Lifecycle.Read)
  jobStatus?: string;
}

/**
 * Migration provider specific settings.
 */
@discriminator("instanceType")
model MigrationProviderSpecificSettings {
  /**
   * Gets the instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Enable migration input.
 */
model EnableMigrationInput {
  /**
   * Enable migration input properties.
   */
  properties: EnableMigrationInputProperties;
}

/**
 * Enable migration input properties.
 */
model EnableMigrationInputProperties {
  /**
   * The policy Id.
   */
  policyId: string;

  /**
   * The provider specific details.
   */
  providerSpecificDetails: EnableMigrationProviderSpecificInput;
}

/**
 * Enable migration provider specific input.
 */
@discriminator("instanceType")
model EnableMigrationProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Update migration item input.
 */
model UpdateMigrationItemInput {
  /**
   * Update migration item input properties.
   */
  properties?: UpdateMigrationItemInputProperties;
}

/**
 * Update migration item input properties.
 */
model UpdateMigrationItemInputProperties {
  /**
   * The provider specific input to update migration item.
   */
  providerSpecificDetails: UpdateMigrationItemProviderSpecificInput;
}

/**
 * Update migration item provider specific input.
 */
@discriminator("instanceType")
model UpdateMigrationItemProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input for migrate.
 */
model MigrateInput {
  /**
   * Migrate input properties.
   */
  properties: MigrateInputProperties;
}

/**
 * Migrate input properties.
 */
model MigrateInputProperties {
  /**
   * The provider specific details.
   */
  providerSpecificDetails: MigrateProviderSpecificInput;
}

/**
 * Migrate provider specific input.
 */
@discriminator("instanceType")
model MigrateProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Collection of migration recovery points.
 */
model MigrationRecoveryPointCollection
  is Azure.Core.Page<MigrationRecoveryPoint>;

/**
 * Migration item recovery point properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrationRecoveryPointProperties {
  /**
   * The recovery point time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;

  /**
   * The recovery point type.
   */
  @visibility(Lifecycle.Read)
  recoveryPointType?: MigrationRecoveryPointType;
}

/**
 * Pause replication input.
 */
model PauseReplicationInput {
  /**
   * Pause replication input properties.
   */
  properties: PauseReplicationInputProperties;
}

/**
 * Pause replication input properties.
 */
model PauseReplicationInputProperties {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Resume replication input.
 */
model ResumeReplicationInput {
  /**
   * Resume replication input properties.
   */
  properties: ResumeReplicationInputProperties;
}

/**
 * Resume replication input properties.
 */
model ResumeReplicationInputProperties {
  /**
   * The provider specific input for resume replication.
   */
  providerSpecificDetails: ResumeReplicationProviderSpecificInput;
}

/**
 * Resume replication provider specific input.
 */
@discriminator("instanceType")
model ResumeReplicationProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Resync input.
 */
model ResyncInput {
  /**
   * Resync input properties.
   */
  properties: ResyncInputProperties;
}

/**
 * Resync input properties.
 */
model ResyncInputProperties {
  /**
   * The provider specific details.
   */
  providerSpecificDetails: ResyncProviderSpecificInput;
}

/**
 * Resync provider specific input.
 */
@discriminator("instanceType")
model ResyncProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input for test migrate.
 */
model TestMigrateInput {
  /**
   * Test migrate input properties.
   */
  properties: TestMigrateInputProperties;
}

/**
 * Test migrate input properties.
 */
model TestMigrateInputProperties {
  /**
   * The provider specific details.
   */
  providerSpecificDetails: TestMigrateProviderSpecificInput;
}

/**
 * Test migrate provider specific input.
 */
@discriminator("instanceType")
model TestMigrateProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input for test migrate cleanup.
 */
model TestMigrateCleanupInput {
  /**
   * Test migrate cleanup input properties.
   */
  properties: TestMigrateCleanupInputProperties;
}

/**
 * Test migrate cleanup input properties.
 */
model TestMigrateCleanupInputProperties {
  /**
   * Test migrate cleanup comments.
   */
  @maxLength(1024)
  comments?: string;
}

/**
 * Protectable item collection.
 */
model ProtectableItemCollection is Azure.Core.Page<ProtectableItem>;

/**
 * Replication protected item custom data details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectableItemProperties {
  /**
   * The name.
   */
  friendlyName?: string;

  /**
   * The protection status.
   */
  protectionStatus?: string;

  /**
   * The ARM resource of protected items.
   */
  replicationProtectedItemId?: string;

  /**
   * The recovery provider ARM Id.
   */
  recoveryServicesProviderId?: string;

  /**
   * The Current protection readiness errors.
   */
  protectionReadinessErrors?: string[];

  /**
   * The list of replication providers supported for the protectable item.
   */
  supportedReplicationProviders?: string[];

  /**
   * The Replication provider custom settings.
   */
  customDetails?: ConfigurationSettings;
}

/**
 * Replication provider specific settings.
 */
@discriminator("instanceType")
model ConfigurationSettings {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Replication protected item collection.
 */
model ReplicationProtectedItemCollection
  is Azure.Core.Page<ReplicationProtectedItem>;

/**
 * Replication protected item custom data details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReplicationProtectedItemProperties {
  /**
   * The name.
   */
  friendlyName?: string;

  /**
   * The type of protected item type.
   */
  protectedItemType?: string;

  /**
   * The protected item ARM Id.
   */
  protectableItemId?: string;

  /**
   * The recovery provider ARM Id.
   */
  recoveryServicesProviderId?: string;

  /**
   * The friendly name of the primary fabric.
   */
  primaryFabricFriendlyName?: string;

  /**
   * The fabric provider of the primary fabric.
   */
  primaryFabricProvider?: string;

  /**
   * The friendly name of recovery fabric.
   */
  recoveryFabricFriendlyName?: string;

  /**
   * The Arm Id of recovery fabric.
   */
  recoveryFabricId?: string;

  /**
   * The name of primary protection container friendly name.
   */
  primaryProtectionContainerFriendlyName?: string;

  /**
   * The name of recovery container friendly name.
   */
  recoveryProtectionContainerFriendlyName?: string;

  /**
   * The protection status.
   */
  protectionState?: string;

  /**
   * The protection state description.
   */
  protectionStateDescription?: string;

  /**
   * The Current active location of the PE.
   */
  activeLocation?: string;

  /**
   * The Test failover state.
   */
  testFailoverState?: string;

  /**
   * The Test failover state description.
   */
  testFailoverStateDescription?: string;

  /**
   * The switch provider state.
   */
  switchProviderState?: string;

  /**
   * The switch provider state description.
   */
  switchProviderStateDescription?: string;

  /**
   * The allowed operations on the Replication protected item.
   */
  allowedOperations?: string[];

  /**
   * The consolidated protection health for the VM taking any issues with SRS as well as all the replication units associated with the VM's replication group into account. This is a string representation of the ProtectionHealth enumeration.
   */
  replicationHealth?: string;

  /**
   * The consolidated failover health for the VM.
   */
  failoverHealth?: string;

  /**
   * List of health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrors?: HealthError[];

  /**
   * The ID of Policy governing this PE.
   */
  policyId?: string;

  /**
   * The name of Policy governing this PE.
   */
  policyFriendlyName?: string;

  /**
   * The Last successful failover time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulFailoverTime?: utcDateTime;

  /**
   * The Last successful test failover time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulTestFailoverTime?: utcDateTime;

  /**
   * The current scenario.
   */
  currentScenario?: CurrentScenarioDetails;

  /**
   * The recovery point ARM Id to which the Vm was failed over.
   */
  failoverRecoveryPointId?: string;

  /**
   * The Replication provider custom settings.
   */
  providerSpecificDetails?: ReplicationProviderSpecificSettings;

  /**
   * The recovery container Id.
   */
  recoveryContainerId?: string;

  /**
   * The correlation Id for events associated with this protected item.
   */
  eventCorrelationId?: string;
}

/**
 * Current scenario details of the protected entity.
 */
model CurrentScenarioDetails {
  /**
   * Scenario name.
   */
  scenarioName?: string;

  /**
   * ARM Id of the job being executed.
   */
  jobId?: string;

  /**
   * Start time of the workflow.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

/**
 * Replication provider specific settings.
 */
@discriminator("instanceType")
model ReplicationProviderSpecificSettings {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Enable protection input.
 */
model EnableProtectionInput {
  /**
   * Enable protection input properties.
   */
  properties?: EnableProtectionInputProperties;
}

/**
 * Enable protection input properties.
 */
model EnableProtectionInputProperties {
  /**
   * The Policy Id.
   */
  policyId?: string;

  /**
   * The protectable item Id.
   */
  protectableItemId?: string;

  /**
   * The ReplicationProviderInput. For HyperVReplicaAzure provider, it will be AzureEnableProtectionInput object. For San provider, it will be SanEnableProtectionInput object. For HyperVReplicaAzure provider, it can be null.
   */
  providerSpecificDetails?: EnableProtectionProviderSpecificInput;
}

/**
 * Enable protection provider specific input.
 */
@discriminator("instanceType")
model EnableProtectionProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Update replication protected item input.
 */
model UpdateReplicationProtectedItemInput {
  /**
   * Update replication protected item properties.
   */
  properties?: UpdateReplicationProtectedItemInputProperties;
}

/**
 * Update protected item input properties.
 */
model UpdateReplicationProtectedItemInputProperties {
  /**
   * Target Azure VM name given by the user.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryAzureVMName?: string;

  /**
   * Target Azure VM size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryAzureVMSize?: string;

  /**
   * Target Azure Network Id.
   */
  selectedRecoveryAzureNetworkId?: string;

  /**
   * The Azure Network Id for test failover.
   */
  selectedTfoAzureNetworkId?: string;

  /**
   * The selected source nic Id which will be used as the primary nic during failover.
   */
  selectedSourceNicId?: string;

  /**
   * The selected option to enable RDP\SSH on target vm after failover. String value of SrsDataContract.EnableRDPOnTargetOption enum.
   */
  enableRdpOnTargetOption?: string;

  /**
   * The list of VM nic details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMNicInputDetails[];

  /**
   * License type.
   */
  licenseType?: LicenseType;

  /**
   * The target availability set Id.
   */
  recoveryAvailabilitySetId?: string;

  /**
   * The provider specific input to update replication protected item.
   */
  providerSpecificDetails?: UpdateReplicationProtectedItemProviderInput;
}

/**
 * Hyper V VM network input details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMNicInputDetails {
  /**
   * The nic Id.
   */
  nicId?: string;

  /**
   * The IP configurations to be used by NIC during test failover and failover.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipConfigs?: IPConfigInputDetails[];

  /**
   * Selection type for failover.
   */
  selectionType?: string;

  /**
   * The id of the NSG associated with the NIC.
   */
  recoveryNetworkSecurityGroupId?: string;

  /**
   * Whether the NIC has accelerated networking enabled.
   */
  enableAcceleratedNetworkingOnRecovery?: boolean;

  /**
   * The NSG to be used by NIC during test failover.
   */
  tfoNetworkSecurityGroupId?: string;

  /**
   * Whether the test NIC has accelerated networking enabled.
   */
  enableAcceleratedNetworkingOnTfo?: boolean;

  /**
   * The name of the NIC to be used when creating target NICs.
   */
  recoveryNicName?: string;

  /**
   * The resource group of the NIC to be used when creating target NICs.
   */
  recoveryNicResourceGroupName?: string;

  /**
   * A value indicating whether an existing NIC is allowed to be reused during failover subject to availability.
   */
  reuseExistingNic?: boolean;

  /**
   * The name of the NIC to be used when creating target NICs in TFO.
   */
  tfoNicName?: string;

  /**
   * The resource group of the NIC to be used when creating target NICs in TFO.
   */
  tfoNicResourceGroupName?: string;

  /**
   * A value indicating whether an existing NIC is allowed to be reused during test failover subject to availability.
   */
  tfoReuseExistingNic?: boolean;

  /**
   * Target NIC name.
   */
  targetNicName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IPConfigInputDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipConfigName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isPrimary?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isSeletedForFailover?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoverySubnetName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryStaticIPAddress?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPublicIPAddressId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryLBBackendAddressPoolIds?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tfoSubnetName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tfoStaticIPAddress?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tfoPublicIPAddressId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tfoLBBackendAddressPoolIds?: string[];
}

/**
 * Update replication protected item provider specific input.
 */
@discriminator("instanceType")
model UpdateReplicationProtectedItemProviderInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input for add disk(s) operation.
 */
model AddDisksInput {
  /**
   * Add disks input properties.
   */
  properties?: AddDisksInputProperties;
}

/**
 * Add Disks input properties.
 */
model AddDisksInputProperties {
  /**
   * The ReplicationProviderInput. For HyperVReplicaAzure provider, it will be AzureEnableProtectionInput object. For San provider, it will be SanEnableProtectionInput object. For HyperVReplicaAzure provider, it can be null.
   */
  providerSpecificDetails: AddDisksProviderSpecificInput;
}

/**
 * Add Disks provider specific input.
 */
@discriminator("instanceType")
model AddDisksProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input to apply recovery point.
 */
model ApplyRecoveryPointInput {
  /**
   * The input properties to apply recovery point.
   */
  properties: ApplyRecoveryPointInputProperties;
}

/**
 * Input properties to apply recovery point.
 */
model ApplyRecoveryPointInputProperties {
  /**
   * The recovery point Id.
   */
  recoveryPointId?: string;

  /**
   * Provider specific input for applying recovery point.
   */
  providerSpecificDetails: ApplyRecoveryPointProviderSpecificInput;
}

/**
 * Provider specific input for apply recovery point.
 */
@discriminator("instanceType")
model ApplyRecoveryPointProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input definition for planned failover.
 */
model PlannedFailoverInput {
  /**
   * Planned failover input properties.
   */
  properties?: PlannedFailoverInputProperties;
}

/**
 * Input definition for planned failover input properties.
 */
model PlannedFailoverInputProperties {
  /**
   * Failover direction.
   */
  failoverDirection?: string;

  /**
   * Provider specific settings.
   */
  providerSpecificDetails?: PlannedFailoverProviderSpecificFailoverInput;
}

/**
 * Provider specific failover input.
 */
@discriminator("instanceType")
model PlannedFailoverProviderSpecificFailoverInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Collection of recovery point details.
 */
model RecoveryPointCollection is Azure.Core.Page<RecoveryPoint>;

/**
 * Recovery point properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPointProperties {
  /**
   * The recovery point time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;

  /**
   * The recovery point type: ApplicationConsistent, CrashConsistent.
   */
  recoveryPointType?: string;

  /**
   * The provider specific details for the recovery point.
   */
  providerSpecificDetails?: ProviderSpecificRecoveryPointDetails;
}

/**
 * Replication provider specific recovery point details.
 */
@discriminator("instanceType")
model ProviderSpecificRecoveryPointDetails {
  /**
   * Gets the provider type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Disable protection input.
 */
model DisableProtectionInput {
  /**
   * Disable protection input properties.
   */
  properties: DisableProtectionInputProperties;
}

/**
 * Disable protection input properties.
 */
model DisableProtectionInputProperties {
  /**
   * Disable protection reason. It can have values NotSpecified/MigrationComplete.
   */
  disableProtectionReason?: DisableProtectionReason;

  /**
   * Replication provider specific input.
   */
  replicationProviderInput?: DisableProtectionProviderSpecificInput;
}

/**
 * Disable protection provider specific input.
 */
@discriminator("instanceType")
model DisableProtectionProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input for remove disk(s) operation.
 */
model RemoveDisksInput {
  /**
   * Remove disk input properties.
   */
  properties?: RemoveDisksInputProperties;
}

/**
 * Remove Disk input properties.
 */
model RemoveDisksInputProperties {
  /**
   * The ReplicationProviderInput. For HyperVReplicaAzure provider, it will be AzureEnableProtectionInput object. For San provider, it will be SanEnableProtectionInput object. For HyperVReplicaAzure provider, it can be null.
   */
  providerSpecificDetails?: RemoveDisksProviderSpecificInput;
}

/**
 * Remove Disk provider specific input.
 */
@discriminator("instanceType")
model RemoveDisksProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Reverse replication input.
 */
model ReverseReplicationInput {
  /**
   * Reverse replication properties.
   */
  properties?: ReverseReplicationInputProperties;
}

/**
 * Reverse replication input properties.
 */
model ReverseReplicationInputProperties {
  /**
   * Failover direction.
   */
  failoverDirection?: string;

  /**
   * Provider specific reverse replication input.
   */
  providerSpecificDetails?: ReverseReplicationProviderSpecificInput;
}

/**
 * Provider specific reverse replication input.
 */
@discriminator("instanceType")
model ReverseReplicationProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Resolve health input.
 */
model ResolveHealthInput {
  /**
   * Disable resolve health input properties.
   */
  properties?: ResolveHealthInputProperties;
}

/**
 * Resolve health input properties.
 */
model ResolveHealthInputProperties {
  /**
   * Health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrors?: ResolveHealthError[];
}

/**
 * Resolve health errors input properties.
 */
model ResolveHealthError {
  /**
   * Health error id.
   */
  healthErrorId?: string;
}

/**
 * Input definition for switch provider.
 */
model SwitchProviderInput {
  /**
   * Switch provider input properties.
   */
  properties?: SwitchProviderInputProperties;
}

/**
 * Input definition for switch provider input properties.
 */
model SwitchProviderInputProperties {
  /**
   * Target provider type.
   */
  targetInstanceType?: string;

  /**
   * Provider specific settings.
   */
  providerSpecificDetails?: SwitchProviderProviderSpecificInput;
}

/**
 * Provider specific switch provider input.
 */
@discriminator("instanceType")
model SwitchProviderProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Target compute size collection.
 */
model TargetComputeSizeCollection is Azure.Core.Page<TargetComputeSize>;

/**
 * Represents applicable recovery vm sizes.
 */
model TargetComputeSize {
  /**
   * The Id.
   */
  id?: string;

  /**
   * The name.
   */
  name?: string;

  /**
   * The Type of the object.
   */
  type?: string;

  /**
   * The custom data.
   */
  properties?: TargetComputeSizeProperties;
}

/**
 * Represents applicable recovery vm sizes properties.
 */
model TargetComputeSizeProperties {
  /**
   * Target compute size name.
   */
  name?: string;

  /**
   * Target compute size display name.
   */
  friendlyName?: string;

  /**
   * The maximum cpu cores count supported by target compute size.
   */
  cpuCoresCount?: int32;

  /**
   * The Available vCPUs supported by target compute size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  vCPUsAvailable?: int32;

  /**
   * The maximum memory in GB supported by target compute size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memoryInGB?: float64;

  /**
   * The maximum data disks count supported by target compute size.
   */
  maxDataDiskCount?: int32;

  /**
   * The maximum Nics count supported by target compute size.
   */
  maxNicsCount?: int32;

  /**
   * The reasons why the target compute size is not applicable for the protected item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errors?: ComputeSizeErrorDetails[];

  /**
   * The value indicating whether the target compute size supports high Iops.
   */
  highIopsSupported?: string;

  /**
   * The supported HyperV Generations.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hyperVGenerations?: string[];
}

/**
 * Represents the error used to indicate why the target compute size is not applicable.
 */
model ComputeSizeErrorDetails {
  /**
   * The error message.
   */
  message?: string;

  /**
   * The severity of the error.
   */
  severity?: string;
}

/**
 * Input definition for test failover.
 */
model TestFailoverInput {
  /**
   * Test failover input properties.
   */
  properties: TestFailoverInputProperties;
}

/**
 * Input definition for test failover input properties.
 */
model TestFailoverInputProperties {
  /**
   * Test failover direction.
   */
  failoverDirection?: string;

  /**
   * Network type to be used for test failover.
   */
  networkType?: string;

  /**
   * The id of the network to be used for test failover.
   */
  networkId?: string;

  /**
   * Provider specific settings.
   */
  providerSpecificDetails?: TestFailoverProviderSpecificInput;
}

/**
 * Provider specific test failover input.
 */
@discriminator("instanceType")
model TestFailoverProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input definition for test failover cleanup.
 */
model TestFailoverCleanupInput {
  /**
   * Test failover cleanup input properties.
   */
  properties: TestFailoverCleanupInputProperties;
}

/**
 * Input definition for test failover cleanup input properties.
 */
model TestFailoverCleanupInputProperties {
  /**
   * Test failover cleanup comments.
   */
  @maxLength(1024)
  comments?: string;
}

/**
 * Input definition for unplanned failover.
 */
model UnplannedFailoverInput {
  /**
   * Unplanned failover input properties.
   */
  properties: UnplannedFailoverInputProperties;
}

/**
 * Input definition for unplanned failover input properties.
 */
model UnplannedFailoverInputProperties {
  /**
   * Failover direction.
   */
  failoverDirection?: string;

  /**
   * Source site operations status.
   */
  sourceSiteOperations?: string;

  /**
   * Provider specific settings.
   */
  providerSpecificDetails?: UnplannedFailoverProviderSpecificInput;
}

/**
 * Provider specific unplanned failover input.
 */
@discriminator("instanceType")
model UnplannedFailoverProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Update appliance for replication protected item input.
 */
model UpdateApplianceForReplicationProtectedItemInput {
  /**
   * Update appliance replication protected item properties.
   */
  properties: UpdateApplianceForReplicationProtectedItemInputProperties;
}

/**
 * Update appliance for protected item input properties.
 */
model UpdateApplianceForReplicationProtectedItemInputProperties {
  /**
   * The target appliance Id.
   */
  targetApplianceId: string;

  /**
   * The provider specific input to update replication protected item.
   */
  providerSpecificDetails: UpdateApplianceForReplicationProtectedItemProviderSpecificInput;
}

/**
 * Update replication protected item provider specific input.
 */
@discriminator("instanceType")
model UpdateApplianceForReplicationProtectedItemProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Request to update the mobility service on a protected item.
 */
model UpdateMobilityServiceRequest {
  /**
   * The properties of the update mobility service request.
   */
  properties?: UpdateMobilityServiceRequestProperties;
}

/**
 * The properties of an update mobility service request.
 */
model UpdateMobilityServiceRequestProperties {
  /**
   * The CS run as account Id.
   */
  runAsAccountId?: string;
}

/**
 * Request to Reinstall the mobility service on a protected item.
 */
model ReinstallMobilityServiceRequest {
  /**
   * The properties of the reinstall mobility service request
   */
  properties?: ReinstallMobilityServiceRequestProperties;
}

/**
 * The properties of an update mobility service request.
 */
model ReinstallMobilityServiceRequestProperties {
  /**
   * The CS run as account Id.
   */
  runAsAccountId?: string;
}

/**
 * Replication protected item collection.
 */
model ReplicationProtectionClusterCollection
  is Azure.Core.Page<ReplicationProtectionCluster>;

/**
 * Replication protection cluster custom data details.
 */
model ReplicationProtectionClusterProperties {
  /**
   * The type of protection cluster type.
   */
  protectionClusterType?: string;

  /**
   * The friendly name of the primary fabric.
   */
  primaryFabricFriendlyName?: string;

  /**
   * The fabric provider of the primary fabric.
   */
  primaryFabricProvider?: string;

  /**
   * The friendly name of recovery fabric.
   */
  recoveryFabricFriendlyName?: string;

  /**
   * The Arm Id of recovery fabric.
   */
  recoveryFabricId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics";
    }
  ]>;

  /**
   * The name of primary protection container friendly name.
   */
  primaryProtectionContainerFriendlyName?: string;

  /**
   * The name of recovery container friendly name.
   */
  recoveryProtectionContainerFriendlyName?: string;

  /**
   * The protection status.
   */
  protectionState?: string;

  /**
   * The protection state description.
   */
  protectionStateDescription?: string;

  /**
   * The Current active location of the Protection cluster.
   */
  activeLocation?: string;

  /**
   * The Test failover state.
   */
  testFailoverState?: string;

  /**
   * The Test failover state description.
   */
  testFailoverStateDescription?: string;

  /**
   * The allowed operations on the Replication protection cluster.
   */
  allowedOperations?: string[];

  /**
   * The consolidated protection health for the VM taking any issues with SRS as well as all the replication units associated with the VM's replication group into account. This is a string representation of the ProtectionHealth enumeration.
   */
  replicationHealth?: string;

  /**
   * List of health errors.
   */
  @identifiers(#[])
  healthErrors?: HealthError[];

  /**
   * The last successful failover time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulFailoverTime?: utcDateTime;

  /**
   * The last successful test failover time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulTestFailoverTime?: utcDateTime;

  /**
   * The name of Policy governing this PE.
   */
  policyFriendlyName?: string;

  /**
   * The current scenario.
   */
  currentScenario?: CurrentScenarioDetails;

  /**
   * The recovery container Id.
   */
  recoveryContainerId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers";
    }
  ]>;

  /**
   * The Agent cluster Id.
   */
  agentClusterId?: string;

  /**
   * The cluster FQDN.
   */
  clusterFqdn?: string;

  /**
   * The List of cluster Node FQDNs.
   */
  clusterNodeFqdns?: string[];

  /**
   * The List of Protected Item Id's.
   */
  clusterProtectedItemIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems";
    }
  ]>[];

  /**
   * The provisioning state of the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * A value indicating whether all nodes of the cluster are registered or not.
   */
  areAllClusterNodesRegistered?: boolean;

  /**
   * The registered node details.
   */
  @identifiers(#["clusterNodeFqdn"])
  clusterRegisteredNodes?: RegisteredClusterNodes[];

  /**
   * The Replication cluster provider custom settings.
   */
  providerSpecificDetails?: ReplicationClusterProviderSpecificSettings;

  /**
   * The shared disk properties.
   */
  sharedDiskProperties?: SharedDiskReplicationItemProperties;

  /**
   * The Policy Id.
   */
  policyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationPolicies";
    }
  ]>;
}

/**
 * Extended location of the resource.
 */
model RegisteredClusterNodes {
  /**
   * The cluster node name.
   */
  clusterNodeFqdn?: string;

  /**
   * The machine ID.
   */
  machineId?: string;

  /**
   * The BIOS ID.
   */
  biosId?: string;

  /**
   * A value indicating whether this represents virtual entity hosting all the shared disks.
   */
  isSharedDiskVirtualNode?: boolean;
}

/**
 * Replication cluster provider specific settings.
 */
@discriminator("instanceType")
model ReplicationClusterProviderSpecificSettings {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Shared Disk Replication item custom data details.
 */
model SharedDiskReplicationItemProperties {
  /**
   * The protection state of shared disk.
   */
  protectionState?: string;

  /**
   * The tfo state of shared disk.
   */
  testFailoverState?: string;

  /**
   * The Current active location of the PE.
   */
  activeLocation?: string;

  /**
   * The allowed operations on the Replication protected item.
   */
  allowedOperations?: string[];

  /**
   * The consolidated protection health for the VM taking any issues with SRS as well as all the replication units associated with the VM's replication group into account. This is a string representation of the ProtectionHealth enumeration.
   */
  replicationHealth?: string;

  /**
   * List of health errors.
   */
  @identifiers(#["errorCode"])
  healthErrors?: HealthError[];

  /**
   * The current scenario.
   */
  currentScenario?: CurrentScenarioDetails;

  /**
   * The Replication provider custom settings.
   */
  sharedDiskProviderSpecificDetails?: SharedDiskReplicationProviderSpecificSettings;
}

/**
 * Replication provider specific settings.
 */
@discriminator("instanceType")
model SharedDiskReplicationProviderSpecificSettings {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input definition for apply cluster recovery point.
 */
model ApplyClusterRecoveryPointInput {
  /**
   * The properties to apply cluster recovery point input.
   */
  properties: ApplyClusterRecoveryPointInputProperties;
}

/**
 * Input definition for apply cluster recovery point properties.
 */
model ApplyClusterRecoveryPointInputProperties {
  /**
   * The cluster recovery point id to be passed to failover to a particular recovery point.
   */
  clusterRecoveryPointId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectionClusters/recoveryPoints";
    }
  ]>;

  /**
   * The list of individual node recovery points.
   */
  individualNodeRecoveryPoints?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems";
    }
  ]>[];

  /**
   * The provider specific input for applying cluster recovery point.
   */
  providerSpecificDetails: ApplyClusterRecoveryPointProviderSpecificInput;
}

/**
 * Provider specific input for apply cluster recovery point.
 */
@discriminator("instanceType")
model ApplyClusterRecoveryPointProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Collection of cluster recovery point details.
 */
model ClusterRecoveryPointCollection is Azure.Core.Page<ClusterRecoveryPoint>;

/**
 * Cluster recovery point properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClusterRecoveryPointProperties {
  /**
   * The recovery point time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;

  /**
   * The recovery point type.
   */
  recoveryPointType?: ClusterRecoveryPointType;

  /**
   * The provider specific details for the recovery point.
   */
  providerSpecificDetails?: ClusterProviderSpecificRecoveryPointDetails;
}

/**
 * Replication provider specific cluster recovery point details.
 */
@discriminator("instanceType")
model ClusterProviderSpecificRecoveryPointDetails {
  /**
   * Gets the provider type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read) instanceType: string;
}

/**
 * Input definition for test cluster failover.
 */
model ClusterTestFailoverInput {
  /**
   * Test failover input properties.
   */
  properties: ClusterTestFailoverInputProperties;
}

/**
 * Input definition for test failover input properties.
 */
model ClusterTestFailoverInputProperties {
  /**
   * Failover direction.
   */
  failoverDirection?: FailoverDirection;

  /**
   * Network type to be used for test failover.
   */
  networkType?: string;

  /**
   * The id of the network to be used for test failover.
   */
  networkId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  /**
   * Provider specific settings.
   */
  providerSpecificDetails?: ClusterTestFailoverProviderSpecificInput;
}

/**
 * Provider specific test cluster failover input.
 */
@discriminator("instanceType")
model ClusterTestFailoverProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Input definition for test failover cleanup for cluster.
 */
model ClusterTestFailoverCleanupInput {
  /**
   * Test failover cleanup input properties.
   */
  properties: ClusterTestFailoverCleanupInputProperties;
}

/**
 * Input definition for test failover cleanup input properties.
 */
model ClusterTestFailoverCleanupInputProperties {
  /**
   * Test failover cleanup comments.
   */
  @maxLength(1024)
  comments?: string;
}

/**
 * Input definition for unplanned cluster failover.
 */
model ClusterUnplannedFailoverInput {
  /**
   * Unplanned failover input properties.
   */
  properties: ClusterUnplannedFailoverInputProperties;
}

/**
 * Input definition for unplanned failover input properties.
 */
model ClusterUnplannedFailoverInputProperties {
  /**
   * Failover direction.
   */
  failoverDirection?: string;

  /**
   * Source site operations status.
   */
  sourceSiteOperations?: string;

  /**
   * Provider specific settings.
   */
  providerSpecificDetails?: ClusterUnplannedFailoverProviderSpecificInput;
}

/**
 * Provider specific unplanned cluster failover input.
 */
@discriminator("instanceType")
model ClusterUnplannedFailoverProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Protection container mapping collection class.
 */
model ProtectionContainerMappingCollection
  is Azure.Core.Page<ProtectionContainerMapping>;

/**
 * Protection container mapping properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProtectionContainerMappingProperties {
  /**
   * Paired protection container ARM ID.
   */
  targetProtectionContainerId?: string;

  /**
   * Friendly name of paired container.
   */
  targetProtectionContainerFriendlyName?: string;

  /**
   * Provider specific provider details.
   */
  providerSpecificDetails?: ProtectionContainerMappingProviderSpecificDetails;

  /**
   * Health of pairing.
   */
  health?: string;

  /**
   * Health error.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrorDetails?: HealthError[];

  /**
   * Policy ARM Id.
   */
  policyId?: string;

  /**
   * Association Status.
   */
  state?: string;

  /**
   * Friendly name of source protection container.
   */
  sourceProtectionContainerFriendlyName?: string;

  /**
   * Friendly name of source fabric.
   */
  sourceFabricFriendlyName?: string;

  /**
   * Friendly name of target fabric.
   */
  targetFabricFriendlyName?: string;

  /**
   * Friendly name of replication policy.
   */
  policyFriendlyName?: string;
}

/**
 * Container mapping provider specific details.
 */
@discriminator("instanceType")
model ProtectionContainerMappingProviderSpecificDetails {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Configure pairing input.
 */
model CreateProtectionContainerMappingInput {
  /**
   * Configure protection input properties.
   */
  properties?: CreateProtectionContainerMappingInputProperties;
}

/**
 * Configure pairing input properties.
 */
model CreateProtectionContainerMappingInputProperties {
  /**
   * The target unique protection container name.
   */
  targetProtectionContainerId?: string;

  /**
   * Applicable policy.
   */
  policyId?: string;

  /**
   * Provider specific input for pairing.
   */
  providerSpecificInput?: ReplicationProviderSpecificContainerMappingInput;
}

/**
 * Provider specific input for pairing operations.
 */
@discriminator("instanceType")
model ReplicationProviderSpecificContainerMappingInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Container pairing update input.
 */
model UpdateProtectionContainerMappingInput {
  /**
   * Update protection container mapping input properties.
   */
  properties?: UpdateProtectionContainerMappingInputProperties;
}

/**
 * Container pairing update input.
 */
model UpdateProtectionContainerMappingInputProperties {
  /**
   * Provider specific input for updating protection container mapping.
   */
  providerSpecificInput?: ReplicationProviderSpecificUpdateContainerMappingInput;
}

/**
 * Provider specific input for update pairing operations.
 */
@discriminator("instanceType")
model ReplicationProviderSpecificUpdateContainerMappingInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Container unpairing input.
 */
model RemoveProtectionContainerMappingInput {
  /**
   * Configure protection input properties.
   */
  properties?: RemoveProtectionContainerMappingInputProperties;
}

/**
 * Unpairing input properties.
 */
model RemoveProtectionContainerMappingInputProperties {
  /**
   * Provider specific input for unpairing.
   */
  providerSpecificInput?: ReplicationProviderContainerUnmappingInput;
}

/**
 * Provider specific input for unpairing operations.
 */
model ReplicationProviderContainerUnmappingInput {
  /**
   * The class type.
   */
  instanceType?: string;
}

/**
 * Switch cluster protection input.
 */
model SwitchClusterProtectionInput {
  /**
   * Switch cluster protection properties.
   */
  properties?: SwitchClusterProtectionInputProperties;
}

/**
 * Switch cluster protection input properties.
 */
model SwitchClusterProtectionInputProperties {
  /**
   * The unique replication protection cluster name.
   */
  replicationProtectionClusterName?: string;

  /**
   * Provider specific switch protection input.
   */
  providerSpecificDetails?: SwitchClusterProtectionProviderSpecificInput;
}

/**
 * Provider specific switch cluster protection input.
 */
@discriminator("instanceType")
model SwitchClusterProtectionProviderSpecificInput {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Switch protection input.
 */
model SwitchProtectionInput {
  /**
   * Switch protection properties.
   */
  properties?: SwitchProtectionInputProperties;
}

/**
 * Switch protection input properties.
 */
model SwitchProtectionInputProperties {
  /**
   * The unique replication protected item name.
   */
  replicationProtectedItemName?: string;

  /**
   * Provider specific switch protection input.
   */
  providerSpecificDetails?: SwitchProtectionProviderSpecificInput;
}

/**
 * Provider specific switch protection input.
 */
@discriminator("instanceType")
model SwitchProtectionProviderSpecificInput {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Collection of providers.
 */
model RecoveryServicesProviderCollection
  is Azure.Core.Page<RecoveryServicesProvider>;

/**
 * Recovery services provider properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryServicesProviderProperties {
  /**
   * Type of the site.
   */
  fabricType?: string;

  /**
   * Friendly name of the DRA.
   */
  friendlyName?: string;

  /**
   * The provider version.
   */
  providerVersion?: string;

  /**
   * The fabric provider.
   */
  serverVersion?: string;

  /**
   * DRA version status.
   */
  providerVersionState?: string;

  /**
   * Expiry date of the version.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  providerVersionExpiryDate?: utcDateTime;

  /**
   * The fabric friendly name.
   */
  fabricFriendlyName?: string;

  /**
   * Time when last heartbeat was sent by the DRA.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartBeat?: utcDateTime;

  /**
   * A value indicating whether DRA is responsive.
   */
  connectionStatus?: string;

  /**
   * Number of protected VMs currently managed by the DRA.
   */
  protectedItemCount?: int32;

  /**
   * The scenarios allowed on this provider.
   */
  allowedScenarios?: string[];

  /**
   * The recovery services provider health error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrorDetails?: HealthError[];

  /**
   * The DRA Id.
   */
  draIdentifier?: string;

  /**
   * The machine Id.
   */
  machineId?: string;

  /**
   * The machine name.
   */
  machineName?: string;

  /**
   * The Bios Id.
   */
  biosId?: string;

  /**
   * The authentication identity details.
   */
  authenticationIdentityDetails?: IdentityProviderDetails;

  /**
   * The resource access identity details.
   */
  resourceAccessIdentityDetails?: IdentityProviderDetails;

  /**
   * The data plane authentication identity details.
   */
  dataPlaneAuthenticationIdentityDetails?: IdentityProviderDetails;

  /**
   * The provider version details.
   */
  providerVersionDetails?: VersionDetails;
}

/**
 * Identity provider details.
 */
model IdentityProviderDetails {
  /**
   * The tenant Id for the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  tenantId?: string;

  /**
   * The application/client Id for the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  applicationId?: string;

  /**
   * The object Id of the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  objectId?: string;

  /**
   * The intended Audience of the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  audience?: string;

  /**
   * The base authority for Azure Active Directory authentication.
   */
  aadAuthority?: string;
}

/**
 * Version related details.
 */
model VersionDetails {
  /**
   * The agent version.
   */
  version?: string;

  /**
   * Version expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDate?: utcDateTime;

  /**
   * A value indicating whether security update required.
   */
  status?: AgentVersionStatus;
}

/**
 * Input required to add a provider.
 */
model AddRecoveryServicesProviderInput {
  /**
   * The properties of an add provider request.
   */
  properties: AddRecoveryServicesProviderInputProperties;
}

/**
 * The properties of an add provider request.
 */
model AddRecoveryServicesProviderInputProperties {
  /**
   * The name of the machine where the provider is getting added.
   */
  machineName: string;

  /**
   * The Id of the machine where the provider is getting added.
   */
  machineId?: string;

  /**
   * The Bios Id of the machine.
   */
  biosId?: string;

  /**
   * The identity provider input for DRA authentication.
   */
  authenticationIdentityInput: IdentityProviderInput;

  /**
   * The identity provider input for resource access.
   */
  resourceAccessIdentityInput: IdentityProviderInput;

  /**
   * The identity provider input for data plane authentication.
   */
  dataPlaneAuthenticationIdentityInput?: IdentityProviderInput;
}

/**
 * Identity provider input.
 */
model IdentityProviderInput {
  /**
   * The tenant Id for the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  tenantId: string;

  /**
   * The application/client Id for the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  applicationId: string;

  /**
   * The object Id of the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  objectId: string;

  /**
   * The intended Audience of the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  audience: string;

  /**
   * The base authority for Azure Active Directory authentication.
   */
  aadAuthority: string;
}

/**
 * Collection of storage details.
 */
model StorageClassificationCollection is Azure.Core.Page<StorageClassification>;

/**
 * Storage object properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageClassificationProperties {
  /**
   * Friendly name of the Storage classification.
   */
  friendlyName?: string;
}

/**
 * Collection of storage mapping details.
 */
model StorageClassificationMappingCollection
  is Azure.Core.Page<StorageClassificationMapping>;

/**
 * Storage mapping properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageClassificationMappingProperties {
  /**
   * Target storage object Id.
   */
  targetStorageClassificationId?: string;
}

/**
 * Storage mapping input.
 */
model StorageClassificationMappingInput {
  /**
   * Storage mapping input properties.
   */
  properties?: StorageMappingInputProperties;
}

/**
 * Storage mapping input properties.
 */
model StorageMappingInputProperties {
  /**
   * The ID of the storage object.
   */
  targetStorageClassificationId?: string;
}

/**
 * Collection of vCenter details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VCenterCollection is Azure.Core.Page<VCenter>;

/**
 * vCenter properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VCenterProperties {
  /**
   * Friendly name of the vCenter.
   */
  friendlyName?: string;

  /**
   * VCenter internal ID.
   */
  internalId?: string;

  /**
   * The time when the last heartbeat was received by vCenter.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * The VCenter discovery status.
   */
  discoveryStatus?: string;

  /**
   * The process server Id.
   */
  processServerId?: string;

  /**
   * The IP address of the vCenter.
   */
  ipAddress?: string;

  /**
   * The infrastructure Id of vCenter.
   */
  infrastructureId?: string;

  /**
   * The port number for discovery.
   */
  port?: string;

  /**
   * The account Id which has privileges to discover the vCenter.
   */
  runAsAccountId?: string;

  /**
   * The ARM resource name of the fabric containing this VCenter.
   */
  fabricArmResourceName?: string;

  /**
   * The health errors for this VCenter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrors?: HealthError[];
}

/**
 * Input required to add vCenter.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AddVCenterRequest {
  /**
   * The properties of an add vCenter request.
   */
  properties?: AddVCenterRequestProperties;
}

/**
 * The properties of an add vCenter request.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AddVCenterRequestProperties {
  /**
   * The friendly name of the vCenter.
   */
  friendlyName?: string;

  /**
   * The IP address of the vCenter to be discovered.
   */
  ipAddress?: string;

  /**
   * The process server Id from where the discovery is orchestrated.
   */
  processServerId?: string;

  /**
   * The port number for discovery.
   */
  port?: string;

  /**
   * The account Id which has privileges to discover the vCenter.
   */
  runAsAccountId?: string;
}

/**
 * Input required to update vCenter.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UpdateVCenterRequest {
  /**
   * The update VCenter Request Properties.
   */
  properties?: UpdateVCenterRequestProperties;
}

/**
 * The properties of an update vCenter request.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UpdateVCenterRequestProperties {
  /**
   * The friendly name of the vCenter.
   */
  friendlyName?: string;

  /**
   * The IP address of the vCenter to be discovered.
   */
  ipAddress?: string;

  /**
   * The process server Id from where the update can be orchestrated.
   */
  processServerId?: string;

  /**
   * The port number for discovery.
   */
  port?: string;

  /**
   * The CS account Id which has privileges to update the vCenter.
   */
  runAsAccountId?: string;
}

/**
 * Collection of jobs.
 */
model JobCollection is Azure.Core.Page<Job>;

/**
 * Job custom data details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobProperties {
  /**
   * The activity id.
   */
  activityId?: string;

  /**
   * The ScenarioName.
   */
  scenarioName?: string;

  /**
   * The DisplayName.
   */
  friendlyName?: string;

  /**
   * The status of the Job. It is one of these values - NotStarted, InProgress, Succeeded, Failed, Cancelled, Suspended or Other.
   */
  state?: string;

  /**
   * The description of the state of the Job. For e.g. - For Succeeded state, description can be Completed, PartiallySucceeded, CompletedWithInformation or Skipped.
   */
  stateDescription?: string;

  /**
   * The tasks.
   */
  tasks?: ASRTask[];

  /**
   * The errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errors?: JobErrorDetails[];

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
   * The Allowed action the job.
   */
  allowedActions?: string[];

  /**
   * The affected Object Id.
   */
  targetObjectId?: string;

  /**
   * The name of the affected object.
   */
  targetObjectName?: string;

  /**
   * The type of the affected object which is of Microsoft.Azure.SiteRecovery.V2015_11_10.AffectedObjectType class.
   */
  targetInstanceType?: string;

  /**
   * The custom job details like test failover job details.
   */
  customDetails?: JobDetails;
}

/**
 * Task of the Job.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ASRTask {
  /**
   * The Id.
   */
  taskId?: string;

  /**
   * The unique Task name.
   */
  name?: string;

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
   * The state/actions applicable on this task.
   */
  allowedActions?: string[];

  /**
   * The name.
   */
  friendlyName?: string;

  /**
   * The State. It is one of these values - NotStarted, InProgress, Succeeded, Failed, Cancelled, Suspended or Other.
   */
  state?: string;

  /**
   * The description of the task state. For example - For Succeeded state, description can be Completed, PartiallySucceeded, CompletedWithInformation or Skipped.
   */
  stateDescription?: string;

  /**
   * The type of task. Details in CustomDetails property depend on this type.
   */
  taskType?: string;

  /**
   * The custom task details based on the task type.
   */
  customDetails?: TaskTypeDetails;

  /**
   * The custom task details based on the task type, if the task type is GroupTaskDetails or one of the types derived from it.
   */
  groupTaskCustomDetails?: GroupTaskDetails;

  /**
   * The task error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errors?: JobErrorDetails[];
}

/**
 * Task details based on specific task type.
 */
@discriminator("instanceType")
model TaskTypeDetails {
  /**
   * The type of task details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * This class represents the group task details when parent child relationship exists in the drill down.
 */
@discriminator("instanceType")
model GroupTaskDetails {
  /**
   * The type of task details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;

  /**
   * The child tasks.
   */
  childTasks?: ASRTask[];
}

/**
 * This class contains the error details per object.
 */
model JobErrorDetails {
  /**
   * The Service error details.
   */
  serviceErrorDetails?: ServiceError;

  /**
   * The Provider error details.
   */
  providerErrorDetails?: ProviderError;

  /**
   * Error level of error.
   */
  errorLevel?: string;

  /**
   * The creation time of job error.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The Id of the task.
   */
  taskId?: string;
}

/**
 * ASR error model.
 */
model ServiceError {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error message.
   */
  message?: string;

  /**
   * Possible causes of error.
   */
  possibleCauses?: string;

  /**
   * Recommended action to resolve error.
   */
  recommendedAction?: string;

  /**
   * Activity Id.
   */
  activityId?: string;
}

/**
 * This class contains the error details per object.
 */
model ProviderError {
  /**
   * The Error code.
   */
  errorCode?: int32;

  /**
   * The Error message.
   */
  errorMessage?: string;

  /**
   * The Provider error Id.
   */
  errorId?: string;

  /**
   * The possible causes for the error.
   */
  possibleCauses?: string;

  /**
   * The recommended action to resolve the error.
   */
  recommendedAction?: string;
}

/**
 * Job details based on specific job type.
 */
@discriminator("instanceType")
model JobDetails {
  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;

  /**
   * The affected object properties like source server, source cloud, target server, target cloud etc. based on the workflow object details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  affectedObjectDetails?: Record<string>;
}

/**
 * Resume job params.
 */
model ResumeJobParams {
  /**
   * Resume job properties.
   */
  properties?: ResumeJobParamsProperties;
}

/**
 * Resume job properties.
 */
model ResumeJobParamsProperties {
  /**
   * Resume job comments.
   */
  comments?: string;
}

/**
 * Query parameter to enumerate jobs.
 */
model JobQueryParameter {
  /**
   * Date time to get jobs from.
   */
  startTime?: string;

  /**
   * Date time to get jobs upto.
   */
  endTime?: string;

  /**
   * The Id of the fabric to search jobs under.
   */
  fabricId?: string;

  /**
   * The type of objects.
   */
  affectedObjectTypes?: string;

  /**
   * The states of the job to be filtered can be in.
   */
  jobStatus?: string;

  /**
   * The output type of the jobs.
   */
  jobOutputType?: ExportJobOutputSerializationType;

  /**
   * The job Name.
   */
  jobName?: string;

  /**
   * The timezone offset for the location of the request (in minutes).
   */
  timezoneOffset?: float64;
}

/**
 * Protection Profile Collection details.
 */
model PolicyCollection is Azure.Core.Page<Policy>;

/**
 * Protection profile custom data details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyProperties {
  /**
   * The FriendlyName.
   */
  friendlyName?: string;

  /**
   * The ReplicationChannelSetting.
   */
  providerSpecificDetails?: PolicyProviderSpecificDetails;
}

/**
 * Base class for Provider specific details for policies.
 */
@discriminator("instanceType")
model PolicyProviderSpecificDetails {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Protection Policy input.
 */
model CreatePolicyInput {
  /**
   * Policy creation properties.
   */
  properties?: CreatePolicyInputProperties;
}

/**
 * Policy creation properties.
 */
model CreatePolicyInputProperties {
  /**
   * The ReplicationProviderSettings.
   */
  providerSpecificInput?: PolicyProviderSpecificInput;
}

/**
 * Base class for provider specific input.
 */
@discriminator("instanceType")
model PolicyProviderSpecificInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Update policy input.
 */
model UpdatePolicyInput {
  /**
   * The ReplicationProviderSettings.
   */
  properties?: UpdatePolicyInputProperties;
}

/**
 * Policy update properties.
 */
model UpdatePolicyInputProperties {
  /**
   * The ReplicationProviderSettings.
   */
  replicationProviderSettings?: PolicyProviderSpecificInput;
}

/**
 * Replication protection intent objects collection.
 */
model ReplicationProtectionIntentCollection
  is Azure.Core.Page<ReplicationProtectionIntent>;

/**
 * Replication protection intent custom data details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReplicationProtectionIntentProperties {
  /**
   * The name.
   */
  friendlyName?: string;

  /**
   * The job Id.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The job state.
   */
  @visibility(Lifecycle.Read)
  jobState?: string;

  /**
   * A value indicating whether the intent object is active.
   */
  @visibility(Lifecycle.Read)
  isActive?: boolean;

  /**
   * The creation time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  creationTimeUTC?: string;

  /**
   * The Replication provider custom settings.
   */
  providerSpecificDetails?: ReplicationProtectionIntentProviderSpecificSettings;
}

/**
 * Replication provider specific settings.
 */
@discriminator("instanceType")
model ReplicationProtectionIntentProviderSpecificSettings {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Create protection intent input.
 */
model CreateProtectionIntentInput {
  /**
   * Create protection intent input properties.
   */
  properties?: CreateProtectionIntentProperties;
}

/**
 * Create protection intent input properties.
 */
model CreateProtectionIntentProperties {
  /**
   * The ReplicationProviderInput. For A2A provider, it will be A2ACreateProtectionIntentInput object.
   */
  providerSpecificDetails?: CreateProtectionIntentProviderSpecificDetails;
}

/**
 * Create protection intent provider specific input.
 */
@discriminator("instanceType")
model CreateProtectionIntentProviderSpecificDetails {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Recovery plan collection details.
 */
model RecoveryPlanCollection is Azure.Core.Page<RecoveryPlan>;

/**
 * Recovery plan properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPlanProperties {
  /**
   * The friendly name.
   */
  friendlyName?: string;

  /**
   * The primary fabric Id.
   */
  primaryFabricId?: string;

  /**
   * The primary fabric friendly name.
   */
  primaryFabricFriendlyName?: string;

  /**
   * The recovery fabric Id.
   */
  recoveryFabricId?: string;

  /**
   * The recovery fabric friendly name.
   */
  recoveryFabricFriendlyName?: string;

  /**
   * The failover deployment model.
   */
  failoverDeploymentModel?: string;

  /**
   * The list of replication providers.
   */
  replicationProviders?: string[];

  /**
   * The list of allowed operations.
   */
  allowedOperations?: string[];

  /**
   * The start time of the last planned failover.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastPlannedFailoverTime?: utcDateTime;

  /**
   * The start time of the last unplanned failover.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUnplannedFailoverTime?: utcDateTime;

  /**
   * The start time of the last test failover.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTestFailoverTime?: utcDateTime;

  /**
   * The current scenario details.
   */
  currentScenario?: CurrentScenarioDetails;

  /**
   * The recovery plan status.
   */
  currentScenarioStatus?: string;

  /**
   * The recovery plan status description.
   */
  currentScenarioStatusDescription?: string;

  /**
   * The recovery plan groups.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groups?: RecoveryPlanGroup[];

  /**
   * The provider id and provider specific details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  providerSpecificDetails?: RecoveryPlanProviderSpecificDetails[];
}

/**
 * Recovery plan group details.
 */
model RecoveryPlanGroup {
  /**
   * The group type.
   */
  groupType: RecoveryPlanGroupType;

  /**
   * The list of protected items.
   */
  replicationProtectedItems?: RecoveryPlanProtectedItem[];

  /**
   * The start group actions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startGroupActions?: RecoveryPlanAction[];

  /**
   * The end group actions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endGroupActions?: RecoveryPlanAction[];
}

/**
 * Recovery plan protected item.
 */
model RecoveryPlanProtectedItem {
  /**
   * The ARM Id of the recovery plan protected item.
   */
  id?: string;

  /**
   * The virtual machine Id.
   */
  virtualMachineId?: string;
}

/**
 * Recovery plan action details.
 */
model RecoveryPlanAction {
  /**
   * The action name.
   */
  actionName: string;

  /**
   * The list of failover types.
   */
  failoverTypes: ReplicationProtectedItemOperation[];

  /**
   * The list of failover directions.
   */
  failoverDirections: PossibleOperationsDirections[];

  /**
   * The custom details.
   */
  customDetails: RecoveryPlanActionDetails;
}

/**
 * Recovery plan action custom details.
 */
@discriminator("instanceType")
model RecoveryPlanActionDetails {
  /**
   * Gets the type of action details (see RecoveryPlanActionDetailsTypes enum for possible values).
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Recovery plan provider specific details.
 */
@discriminator("instanceType")
model RecoveryPlanProviderSpecificDetails {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Create recovery plan input class.
 */
model CreateRecoveryPlanInput {
  /**
   * Recovery plan creation properties.
   */
  properties: CreateRecoveryPlanInputProperties;
}

/**
 * Recovery plan creation properties.
 */
model CreateRecoveryPlanInputProperties {
  /**
   * The primary fabric Id.
   */
  primaryFabricId: string;

  /**
   * The recovery fabric Id.
   */
  recoveryFabricId: string;

  /**
   * The failover deployment model.
   */
  failoverDeploymentModel?: FailoverDeploymentModel;

  /**
   * The recovery plan groups.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groups: RecoveryPlanGroup[];

  /**
   * The provider specific input.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  providerSpecificInput?: RecoveryPlanProviderSpecificInput[];
}

/**
 * Recovery plan provider specific input base class.
 */
@discriminator("instanceType")
model RecoveryPlanProviderSpecificInput {
  /**
   * Gets the Instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Update recovery plan input class.
 */
model UpdateRecoveryPlanInput {
  /**
   * Recovery plan update properties.
   */
  properties?: UpdateRecoveryPlanInputProperties;
}

/**
 * Recovery plan update properties.
 */
model UpdateRecoveryPlanInputProperties {
  /**
   * The recovery plan groups.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groups?: RecoveryPlanGroup[];
}

/**
 * Recovery plan planned failover input.
 */
model RecoveryPlanPlannedFailoverInput {
  /**
   * The recovery plan planned failover input properties.
   */
  properties: RecoveryPlanPlannedFailoverInputProperties;
}

/**
 * Recovery plan planned failover input properties.
 */
model RecoveryPlanPlannedFailoverInputProperties {
  /**
   * The failover direction.
   */
  failoverDirection: PossibleOperationsDirections;

  /**
   * The provider specific properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  providerSpecificDetails?: RecoveryPlanProviderSpecificFailoverInput[];
}

/**
 * Recovery plan provider specific failover input.
 */
@discriminator("instanceType")
model RecoveryPlanProviderSpecificFailoverInput {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceType: string;
}

/**
 * Recovery plan test failover input.
 */
model RecoveryPlanTestFailoverInput {
  /**
   * The recovery plan test failover input properties.
   */
  properties: RecoveryPlanTestFailoverInputProperties;
}

/**
 * Recovery plan test failover input properties.
 */
model RecoveryPlanTestFailoverInputProperties {
  /**
   * The failover direction.
   */
  failoverDirection: PossibleOperationsDirections;

  /**
   * The network type to be used for test failover.
   */
  networkType: string;

  /**
   * The Id of the network to be used for test failover.
   */
  networkId?: string;

  /**
   * The provider specific properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  providerSpecificDetails?: RecoveryPlanProviderSpecificFailoverInput[];
}

/**
 * Recovery plan test failover cleanup input.
 */
model RecoveryPlanTestFailoverCleanupInput {
  /**
   * The recovery plan test failover cleanup input properties.
   */
  properties: RecoveryPlanTestFailoverCleanupInputProperties;
}

/**
 * Recovery plan test failover cleanup input properties.
 */
model RecoveryPlanTestFailoverCleanupInputProperties {
  /**
   * The test failover cleanup comments.
   */
  @maxLength(1024)
  comments?: string;
}

/**
 * Recovery plan unplanned failover input.
 */
model RecoveryPlanUnplannedFailoverInput {
  /**
   * The recovery plan unplanned failover input properties.
   */
  properties: RecoveryPlanUnplannedFailoverInputProperties;
}

/**
 * Recovery plan unplanned failover input properties.
 */
model RecoveryPlanUnplannedFailoverInputProperties {
  /**
   * The failover direction.
   */
  failoverDirection: PossibleOperationsDirections;

  /**
   * A value indicating whether source site operations are required.
   */
  sourceSiteOperations: SourceSiteOperations;

  /**
   * The provider specific properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  providerSpecificDetails?: RecoveryPlanProviderSpecificFailoverInput[];
}

/**
 * Supported operating systems.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SupportedOperatingSystems extends Resource {
  /**
   * The supported operating systems properties.
   */
  properties?: SupportedOSProperties;
}

/**
 * Supported operating systems properties.
 */
model SupportedOSProperties {
  /**
   * The supported operating systems property list.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportedOsList?: SupportedOSProperty[];
}

/**
 * Supported operating systems property.
 */
model SupportedOSProperty {
  /**
   * The replication provider type.
   */
  instanceType?: string;

  /**
   * The list of supported operating systems.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportedOs?: SupportedOSDetails[];
}

/**
 * Supported operating system details.
 */
model SupportedOSDetails {
  /**
   * The name.
   */
  osName?: string;

  /**
   * The type.
   */
  osType?: string;

  /**
   * The list of version for operating system.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  osVersions?: OSVersionWrapper[];
}

/**
 * Wrapper model for OSVersion to include version and service pack info.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OSVersionWrapper {
  /**
   * The version.
   */
  version?: string;

  /**
   * The service pack.
   */
  servicePack?: string;
}

/**
 * Vault health details definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VaultHealthDetails extends Resource {
  /**
   * The vault health related data.
   */
  properties?: VaultHealthProperties;
}

/**
 * class to define the health summary of the Vault.
 */
model VaultHealthProperties {
  /**
   * The list of errors on the vault.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vaultErrors?: HealthError[];

  /**
   * The list of the health detail of the protected items in the vault.
   */
  protectedItemsHealth?: ResourceHealthSummary;

  /**
   * The list of the health detail of the fabrics in the vault.
   */
  fabricsHealth?: ResourceHealthSummary;

  /**
   * The list of the health detail of the containers in the vault.
   */
  containersHealth?: ResourceHealthSummary;
}

/**
 * Base class to define the health summary of the resources contained under an Arm resource.
 */
model ResourceHealthSummary {
  /**
   * The count of total resources under the container.
   */
  resourceCount?: int32;

  /**
   * The list of summary of health errors across the resources under the container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  issues?: HealthErrorSummary[];

  /**
   * The categorized resource counts.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  categorizedResourceCounts?: Record<int32>;
}

/**
 * class to define the summary of the health error details.
 */
model HealthErrorSummary {
  /**
   * The code of the health error.
   */
  summaryCode?: string;

  /**
   * The category of the health error.
   */
  category?: HealthErrorCategory;

  /**
   * Severity of error.
   */
  severity?: Severity;

  /**
   * The summary message of the health error.
   */
  summaryMessage?: string;

  /**
   * The type of affected ARM resource.
   */
  affectedResourceType?: string;

  /**
   * The sub type of any subcomponent within the ARM resource that this might be applicable. Value remains null if not applicable.
   */
  affectedResourceSubtype?: string;

  /**
   * The list of affected resource correlation Ids. This can be used to uniquely identify the count of items affected by a specific category and severity as well as count of item affected by an specific issue.
   */
  affectedResourceCorrelationIds?: string[];
}

/**
 * Vault setting collection.
 */
model VaultSettingCollection is Azure.Core.Page<VaultSetting>;

/**
 * Vault setting properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VaultSettingProperties {
  /**
   * The migration solution ARM Id.
   */
  migrationSolutionId?: string;

  /**
   * VMware to Azure provider type.
   */
  vmwareToAzureProviderType?: string;
}

/**
 * Input to create vault setting.
 */
model VaultSettingCreationInput {
  /**
   * Vault setting creation input properties.
   */
  properties: VaultSettingCreationInputProperties;
}

/**
 * Input to create vault setting.
 */
model VaultSettingCreationInputProperties {
  /**
   * The migration solution Id.
   */
  migrationSolutionId?: string;

  /**
   * VMware to Azure provider type.
   */
  vmwareToAzureProviderType?: string;
}

/**
 * A2A source agent reinstall blocking error details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AAgentReinstallBlockingErrorDetails {
  /**
   * error code.
   */
  errorCode?: string;

  /**
   * error message.
   */
  errorMessage?: string;

  /**
   * possible causes.
   */
  possibleCauses?: string;

  /**
   * recommended action.
   */
  recommendedAction?: string;

  /**
   * error message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorMessageParameters?: Record<string>;

  /**
   * error tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorTags?: Record<string>;
}

/**
 * A2A add disk(s) input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AAddDisksInput extends AddDisksProviderSpecificInput {
  /**
   * The list of vm disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: A2AVmDiskInputDetails[];

  /**
   * The list of vm managed disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmManagedDisks?: A2AVmManagedDiskInputDetails[];

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A disk input details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AVmDiskInputDetails {
  /**
   * The disk Uri.
   */
  diskUri: string;

  /**
   * The recovery VHD storage account Id.
   */
  recoveryAzureStorageAccountId: string;

  /**
   * The primary staging storage account Id.
   */
  primaryStagingAzureStorageAccountId: string;
}

/**
 * A2A managed disk input details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AVmManagedDiskInputDetails {
  /**
   * The disk Id.
   */
  diskId: string;

  /**
   * The primary staging storage account Arm Id.
   */
  primaryStagingAzureStorageAccountId: string;

  /**
   * The target resource group Arm Id.
   */
  recoveryResourceGroupId: string;

  /**
   * The replica disk type. Its an optional value and will be same as source disk type if not user provided.
   */
  recoveryReplicaDiskAccountType?: string;

  /**
   * The target disk type after failover. Its an optional value and will be same as source disk type if not user provided.
   */
  recoveryTargetDiskAccountType?: string;

  /**
   * The recovery disk encryption set Id.
   */
  recoveryDiskEncryptionSetId?: string;

  /**
   * The recovery disk encryption information (for one / single pass flows).
   */
  diskEncryptionInfo?: DiskEncryptionInfo;
}

/**
 * Recovery disk encryption info (BEK and KEK).
 */
model DiskEncryptionInfo {
  /**
   * The recovery KeyVault reference for secret.
   */
  diskEncryptionKeyInfo?: DiskEncryptionKeyInfo;

  /**
   * The recovery KeyVault reference for key.
   */
  keyEncryptionKeyInfo?: KeyEncryptionKeyInfo;
}

/**
 * Disk Encryption Key Information (BitLocker Encryption Key (BEK) on Windows).
 */
model DiskEncryptionKeyInfo {
  /**
   * The secret url / identifier.
   */
  secretIdentifier?: string;

  /**
   * The KeyVault resource ARM id for secret.
   */
  keyVaultResourceArmId?: string;
}

/**
 * Key Encryption Key (KEK) information.
 */
model KeyEncryptionKeyInfo {
  /**
   * The key URL / identifier.
   */
  keyIdentifier?: string;

  /**
   * The KeyVault resource ARM Id for key.
   */
  keyVaultResourceArmId?: string;
}

/**
 * A2A provider specific input for apply cluster recovery point.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AApplyClusterRecoveryPointInput
  extends ApplyClusterRecoveryPointProviderSpecificInput {
  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A provider specific cluster recovery point details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AClusterRecoveryPointDetails
  extends ClusterProviderSpecificRecoveryPointDetails {
  /**
   * A value indicating whether the recovery point is multi VM consistent.
   */
  recoveryPointSyncType?: RecoveryPointSyncType;

  /**
   * The list of nodes representing the cluster.
   */
  nodes?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems";
    }
  ]>[];

  /**
   * Gets the provider type.
   */
  instanceType: "A2A";
}

/**
 * ApplyRecoveryPoint input specific to A2A provider.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AApplyRecoveryPointInput
  extends ApplyRecoveryPointProviderSpecificInput {
  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A provider specific input for test cluster failover.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AClusterTestFailoverInput
  extends ClusterTestFailoverProviderSpecificInput {
  /**
   * The cluster recovery point id to be passed to failover to a particular recovery point.
   */
  clusterRecoveryPointId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectionClusters/recoveryPoints";
    }
  ]>;

  /**
   * The list of individual node recovery points.
   */
  individualNodeRecoveryPoints?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems/recoveryPoints";
    }
  ]>[];

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A provider specific input for unplanned cluster failover.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AClusterUnplannedFailoverInput
  extends ClusterUnplannedFailoverProviderSpecificInput {
  /**
   * The cluster recovery point id to be passed to failover to a particular recovery point.
   */
  clusterRecoveryPointId?: string;

  /**
   * The list of individual node recovery points.
   */
  individualNodeRecoveryPoints?: string[];

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A cloud creation input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AContainerCreationInput
  extends ReplicationProviderSpecificContainerCreationInput {
  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A container mapping input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AContainerMappingInput
  extends ReplicationProviderSpecificContainerMappingInput {
  /**
   * A value indicating whether the auto update is enabled.
   */
  agentAutoUpdateStatus?: AgentAutoUpdateStatus;

  /**
   * The automation account arm id.
   */
  automationAccountArmId?: string;

  /**
   * A value indicating the type authentication to use for automation Account.
   */
  automationAccountAuthenticationType?: AutomationAccountAuthenticationType = "RunAsAccount";

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A create protection intent input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ACreateProtectionIntentInput
  extends CreateProtectionIntentProviderSpecificDetails {
  /**
   * The fabric specific object Id of the virtual machine.
   */
  fabricObjectId: string;

  /**
   * The primary location for the virtual machine.
   */
  primaryLocation: string;

  /**
   * The recovery location for the virtual machine.
   */
  recoveryLocation: string;

  /**
   * The recovery subscription Id of the virtual machine.
   */
  recoverySubscriptionId: string;

  /**
   * The recovery availability type of the virtual machine.
   */
  recoveryAvailabilityType: A2ARecoveryAvailabilityType;

  /**
   * The protection profile custom inputs.
   */
  protectionProfileCustomInput?: ProtectionProfileCustomDetails;

  /**
   * The recovery resource group Id. Valid for V2 scenarios.
   */
  recoveryResourceGroupId: string;

  /**
   * The primary staging storage account input.
   */
  primaryStagingStorageAccountCustomInput?: StorageAccountCustomDetails;

  /**
   * The recovery availability set input.
   */
  recoveryAvailabilitySetCustomInput?: RecoveryAvailabilitySetCustomDetails;

  /**
   * The recovery virtual network input.
   */
  recoveryVirtualNetworkCustomInput?: RecoveryVirtualNetworkCustomDetails;

  /**
   * The recovery proximity placement group custom input.
   */
  recoveryProximityPlacementGroupCustomInput?: RecoveryProximityPlacementGroupCustomDetails;

  /**
   * A value indicating whether the auto protection is enabled.
   */
  autoProtectionOfDataDisk?: AutoProtectionOfDataDisk;

  /**
   * The list of vm disk inputs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: A2AProtectionIntentDiskInputDetails[];

  /**
   * The list of vm managed disk inputs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmManagedDisks?: A2AProtectionIntentManagedDiskInputDetails[];

  /**
   * The multi vm group name.
   */
  multiVmGroupName?: string;

  /**
   * The multi vm group id.
   */
  multiVmGroupId?: string;

  /**
   * The boot diagnostic storage account.
   */
  recoveryBootDiagStorageAccount?: StorageAccountCustomDetails;

  /**
   * The recovery disk encryption information (for two pass flows).
   */
  diskEncryptionInfo?: DiskEncryptionInfo;

  /**
   * The recovery availability zone.
   */
  recoveryAvailabilityZone?: string;

  /**
   * A value indicating whether the auto update is enabled.
   */
  agentAutoUpdateStatus?: AgentAutoUpdateStatus;

  /**
   * A value indicating the authentication type for automation account. The default value is "RunAsAccount".
   */
  automationAccountAuthenticationType?: AutomationAccountAuthenticationType = "RunAsAccount";

  /**
   * The automation account arm id.
   */
  automationAccountArmId?: string;

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * Protection Profile custom input.
 */
@discriminator("resourceType")
model ProtectionProfileCustomDetails {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceType: string;
}

/**
 * Storage account custom input.
 */
@discriminator("resourceType")
model StorageAccountCustomDetails {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceType: string;
}

/**
 * Recovery Availability Set custom input.
 */
@discriminator("resourceType")
model RecoveryAvailabilitySetCustomDetails {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceType: string;
}

/**
 * Recovery Virtual network custom input.
 */
@discriminator("resourceType")
model RecoveryVirtualNetworkCustomDetails {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceType: string;
}

/**
 * Recovery Proximity placement group custom input.
 */
@discriminator("resourceType")
model RecoveryProximityPlacementGroupCustomDetails {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceType: string;
}

/**
 * Azure VM unmanaged disk input details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AProtectionIntentDiskInputDetails {
  /**
   * The disk Uri.
   */
  diskUri: string;

  /**
   * The recovery VHD storage account input.
   */
  recoveryAzureStorageAccountCustomInput?: StorageAccountCustomDetails;

  /**
   * The primary staging storage account input.
   */
  primaryStagingStorageAccountCustomInput?: StorageAccountCustomDetails;
}

/**
 * Azure VM managed disk input details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AProtectionIntentManagedDiskInputDetails {
  /**
   * The disk Id.
   */
  diskId: string;

  /**
   * The primary staging storage account input.
   */
  primaryStagingStorageAccountCustomInput?: StorageAccountCustomDetails;

  /**
   * The recovery resource group input.
   */
  recoveryResourceGroupCustomInput?: RecoveryResourceGroupCustomDetails;

  /**
   * The replica disk type. Its an optional value and will be same as source disk type if not user provided.
   */
  recoveryReplicaDiskAccountType?: string;

  /**
   * The target disk type after failover. Its an optional value and will be same as source disk type if not user provided.
   */
  recoveryTargetDiskAccountType?: string;

  /**
   * The recovery disk encryption set Id.
   */
  recoveryDiskEncryptionSetId?: string;

  /**
   * The recovery disk encryption information (for one / single pass flows).
   */
  diskEncryptionInfo?: DiskEncryptionInfo;
}

/**
 * Recovery Resource Group custom input.
 */
@discriminator("resourceType")
model RecoveryResourceGroupCustomDetails {
  /**
   * The class type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceType: string;
}

/**
 * ApplyRecoveryPoint input specific to A2ACrossClusterMigration provider.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ACrossClusterMigrationApplyRecoveryPointInput
  extends ApplyRecoveryPointProviderSpecificInput {
  /**
   * The class type.
   */
  instanceType: "A2ACrossClusterMigration";
}

/**
 * A2ACrossClusterMigration cloud creation input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ACrossClusterMigrationContainerCreationInput
  extends ReplicationProviderSpecificContainerCreationInput {
  /**
   * The class type.
   */
  instanceType: "A2ACrossClusterMigration";
}

/**
 * A2A Cross-Cluster Migration enable protection input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ACrossClusterMigrationEnableProtectionInput
  extends EnableProtectionProviderSpecificInput {
  /**
   * The fabric specific object Id of the virtual machine.
   */
  fabricObjectId?: string;

  /**
   * The recovery container Id.
   */
  recoveryContainerId?: string;

  /**
   * The class type.
   */
  instanceType: "A2ACrossClusterMigration";
}

/**
 * A2A Cross-Cluster Migration Policy creation input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ACrossClusterMigrationPolicyCreationInput
  extends PolicyProviderSpecificInput {
  /**
   * The class type.
   */
  instanceType: "A2ACrossClusterMigration";
}

/**
 * A2A provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ACrossClusterMigrationReplicationDetails
  extends ReplicationProviderSpecificSettings {
  /**
   * The fabric specific object Id of the virtual machine.
   */
  fabricObjectId?: string;

  /**
   * Primary fabric location.
   */
  primaryFabricLocation?: string;

  /**
   * The type of operating system.
   */
  osType?: string;

  /**
   * The protection state for the vm.
   */
  vmProtectionState?: string;

  /**
   * The protection state description for the vm.
   */
  vmProtectionStateDescription?: string;

  /**
   * An id associated with the PE that survives actions like switch protection which change the backing PE/CPE objects internally.The lifecycle id gets carried forward to have a link/continuity in being able to have an Id that denotes the "same" protected item even though other internal Ids/ARM Id might be changing.
   */
  lifecycleId?: string;

  /**
   * Gets the Instance type.
   */
  instanceType: "A2ACrossClusterMigration";
}

/**
 * A2A enable protection input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AEnableProtectionInput extends EnableProtectionProviderSpecificInput {
  /**
   * The fabric specific object Id of the virtual machine.
   */
  fabricObjectId: string;

  /**
   * The recovery container Id.
   */
  recoveryContainerId?: string;

  /**
   * The recovery resource group Id. Valid for V2 scenarios.
   */
  recoveryResourceGroupId?: string;

  /**
   * The recovery cloud service Id. Valid for V1 scenarios.
   */
  recoveryCloudServiceId?: string;

  /**
   * The recovery availability set Id.
   */
  recoveryAvailabilitySetId?: string;

  /**
   * The recovery proximity placement group Id.
   */
  recoveryProximityPlacementGroupId?: string;

  /**
   * The list of vm disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: A2AVmDiskInputDetails[];

  /**
   * The list of vm managed disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmManagedDisks?: A2AVmManagedDiskInputDetails[];

  /**
   * The multi vm group name.
   */
  multiVmGroupName?: string;

  /**
   * The multi vm group id.
   */
  multiVmGroupId?: string;

  /**
   * The replication protection cluster Id.
   */
  protectionClusterId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectionClusters";
    }
  ]>;

  /**
   * The boot diagnostic storage account.
   */
  recoveryBootDiagStorageAccountId?: string;

  /**
   * The recovery disk encryption information (for two pass flows).
   */
  diskEncryptionInfo?: DiskEncryptionInfo;

  /**
   * The recovery availability zone.
   */
  recoveryAvailabilityZone?: string;

  /**
   * The recovery extended location.
   */
  recoveryExtendedLocation?: ExtendedLocation;

  /**
   * The recovery Azure virtual network ARM id.
   */
  recoveryAzureNetworkId?: string;

  /**
   * The recovery subnet name.
   */
  recoverySubnetName?: string;

  /**
   * The virtual machine scale set Id.
   */
  recoveryVirtualMachineScaleSetId?: string;

  /**
   * The recovery capacity reservation group Id.
   */
  recoveryCapacityReservationGroupId?: string;

  /**
   * the platform fault domain.
   */
  platformFaultDomain?: int32;

  /**
   * A value indicating whether the auto protection is enabled.
   */
  autoProtectionOfDataDisk?: AutoProtectionOfDataDisk;

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * Extended location of the resource.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name: string;

  /**
   * The extended location type.
   */
  type: ExtendedLocationType;
}

/**
 * Model class for event details of a A2A event.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AEventDetails extends EventProviderSpecificDetails {
  /**
   * The protected item arm name.
   */
  protectedItemName?: string;

  /**
   * The azure vm arm id.
   */
  fabricObjectId?: string;

  /**
   * Fabric arm name.
   */
  fabricName?: string;

  /**
   * The fabric location.
   */
  fabricLocation?: string;

  /**
   * Remote fabric arm name.
   */
  remoteFabricName?: string;

  /**
   * Remote fabric location.
   */
  remoteFabricLocation?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "A2A";
}

/**
 * ExtendedLocation details data.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AExtendedLocationDetails {
  /**
   * The primary ExtendedLocation.
   */
  primaryExtendedLocation?: ExtendedLocation;

  /**
   * The recovery ExtendedLocation.
   */
  recoveryExtendedLocation?: ExtendedLocation;
}

/**
 * ExtendedLocation details data.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AFabricSpecificLocationDetails {
  /**
   * The initial source zone info.
   */
  initialPrimaryZone?: string;

  /**
   * The initial target zone info.
   */
  initialRecoveryZone?: string;

  /**
   * The initial primary ExtendedLocation.
   */
  initialPrimaryExtendedLocation?: ExtendedLocation;

  /**
   * The initial recovery ExtendedLocation.
   */
  initialRecoveryExtendedLocation?: ExtendedLocation;

  /**
   * Initial primary fabric location info.
   */
  initialPrimaryFabricLocation?: string;

  /**
   * The initial recovery fabric location info.
   */
  initialRecoveryFabricLocation?: string;

  /**
   * Source zone info.
   */
  primaryZone?: string;

  /**
   * The target zone info.
   */
  recoveryZone?: string;

  /**
   * The primary ExtendedLocation.
   */
  primaryExtendedLocation?: ExtendedLocation;

  /**
   * The recovery ExtendedLocation.
   */
  recoveryExtendedLocation?: ExtendedLocation;

  /**
   * Primary fabric location info.
   */
  primaryFabricLocation?: string;

  /**
   * The recovery fabric location info.
   */
  recoveryFabricLocation?: string;
}

/**
 * A2A Policy creation input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2APolicyCreationInput extends PolicyProviderSpecificInput {
  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistory?: int32;

  /**
   * The crash consistent snapshot frequency (in minutes).
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * The app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled. Value should be 'Enabled' or 'Disabled'.
   */
  multiVmSyncStatus: SetMultiVmSyncStatus;

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A specific policy details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2APolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * The recovery point threshold in minutes.
   */
  recoveryPointThresholdInMinutes?: int32;

  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistory?: int32;

  /**
   * The app consistent snapshot frequency in minutes.
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled.
   */
  multiVmSyncStatus?: string;

  /**
   * The crash consistent snapshot frequency in minutes.
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "A2A";
}

/**
 * A2A protected disk details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AProtectedDiskDetails {
  /**
   * The disk uri.
   */
  diskUri?: string;

  /**
   * The recovery disk storage account.
   */
  recoveryAzureStorageAccountId?: string;

  /**
   * The primary disk storage account.
   */
  primaryDiskAzureStorageAccountId?: string;

  /**
   * Recovery disk uri.
   */
  recoveryDiskUri?: string;

  /**
   * The disk name.
   */
  diskName?: string;

  /**
   * The disk capacity in bytes.
   */
  diskCapacityInBytes?: int64;

  /**
   * The primary staging storage account.
   */
  primaryStagingAzureStorageAccountId?: string;

  /**
   * The type of disk.
   */
  diskType?: string;

  /**
   * A value indicating whether resync is required for this disk.
   */
  resyncRequired?: boolean;

  /**
   * The percentage of the monitoring job. The type of the monitoring job is defined by MonitoringJobType property.
   */
  monitoringPercentageCompletion?: int32;

  /**
   * The type of the monitoring job. The progress is contained in MonitoringPercentageCompletion property.
   */
  monitoringJobType?: string;

  /**
   * The data pending for replication in MB at staging account.
   */
  dataPendingInStagingStorageAccountInMB?: float64;

  /**
   * The data pending at source virtual machine in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataPendingAtSourceAgentInMB?: float64;

  /**
   * The disk state.
   */
  diskState?: string;

  /**
   * The disk level operations list.
   */
  allowedDiskLevelOperation?: string[];

  /**
   * A value indicating whether vm has encrypted os disk or not.
   */
  isDiskEncrypted?: boolean;

  /**
   * The secret URL / identifier (BEK).
   */
  secretIdentifier?: string;

  /**
   * The KeyVault resource id for secret (BEK).
   */
  dekKeyVaultArmId?: string;

  /**
   * A value indicating whether disk key got encrypted or not.
   */
  isDiskKeyEncrypted?: boolean;

  /**
   * The key URL / identifier (KEK).
   */
  keyIdentifier?: string;

  /**
   * The KeyVault resource id for key (KEK).
   */
  kekKeyVaultArmId?: string;

  /**
   * The failover name for the managed disk.
   */
  failoverDiskName?: string;

  /**
   * The test failover name for the managed disk.
   */
  tfoDiskName?: string;
}

/**
 * A2A specific switch cluster protection input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AProtectedItemDetail {
  /**
   * The list of vm managed disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmManagedDisks?: A2AVmManagedDiskInputDetails[];

  /**
   * The recovery resource group Id.
   */
  recoveryResourceGroupId?: string;

  /**
   * The recovery availability set.
   */
  recoveryAvailabilitySetId?: string;

  /**
   * The boot diagnostic storage account.
   */
  recoveryBootDiagStorageAccountId?: string;

  /**
   * The recovery availability zone.
   */
  recoveryAvailabilityZone?: string;

  /**
   * The recovery proximity placement group Id.
   */
  recoveryProximityPlacementGroupId?: string;

  /**
   * The virtual machine scale set id.
   */
  recoveryVirtualMachineScaleSetId?: string;

  /**
   * The recovery capacity reservation group Id.
   */
  recoveryCapacityReservationGroupId?: string;

  /**
   * The recovery disk encryption information.
   */
  diskEncryptionInfo?: DiskEncryptionInfo;

  /**
   * The Replication Protected item name.
   */
  replicationProtectedItemName?: string;
}

/**
 * A2A protected managed disk details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AProtectedManagedDiskDetails {
  /**
   * The managed disk Arm id.
   */
  diskId?: string;

  /**
   * The recovery disk resource group Arm Id.
   */
  recoveryResourceGroupId?: string;

  /**
   * Recovery target disk Arm Id.
   */
  recoveryTargetDiskId?: string;

  /**
   * Recovery replica disk Arm Id.
   */
  recoveryReplicaDiskId?: string;

  /**
   * Recovery original target disk Arm Id.
   */
  recoveryOrignalTargetDiskId?: string;

  /**
   * The replica disk type. Its an optional value and will be same as source disk type if not user provided.
   */
  recoveryReplicaDiskAccountType?: string;

  /**
   * The target disk type after failover. Its an optional value and will be same as source disk type if not user provided.
   */
  recoveryTargetDiskAccountType?: string;

  /**
   * The recovery disk encryption set Id.
   */
  recoveryDiskEncryptionSetId?: string;

  /**
   * The primary disk encryption set Id.
   */
  primaryDiskEncryptionSetId?: string;

  /**
   * The disk name.
   */
  diskName?: string;

  /**
   * The disk capacity in bytes.
   */
  diskCapacityInBytes?: int64;

  /**
   * The primary staging storage account.
   */
  primaryStagingAzureStorageAccountId?: string;

  /**
   * The type of disk.
   */
  diskType?: string;

  /**
   * A value indicating whether resync is required for this disk.
   */
  resyncRequired?: boolean;

  /**
   * The percentage of the monitoring job. The type of the monitoring job is defined by MonitoringJobType property.
   */
  monitoringPercentageCompletion?: int32;

  /**
   * The type of the monitoring job. The progress is contained in MonitoringPercentageCompletion property.
   */
  monitoringJobType?: string;

  /**
   * The data pending for replication in MB at staging account.
   */
  dataPendingInStagingStorageAccountInMB?: float64;

  /**
   * The data pending at source virtual machine in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataPendingAtSourceAgentInMB?: float64;

  /**
   * The disk state.
   */
  diskState?: string;

  /**
   * The disk level operations list.
   */
  allowedDiskLevelOperation?: string[];

  /**
   * A value indicating whether vm has encrypted os disk or not.
   */
  isDiskEncrypted?: boolean;

  /**
   * The secret URL / identifier (BEK).
   */
  secretIdentifier?: string;

  /**
   * The KeyVault resource id for secret (BEK).
   */
  dekKeyVaultArmId?: string;

  /**
   * A value indicating whether disk key got encrypted or not.
   */
  isDiskKeyEncrypted?: boolean;

  /**
   * The key URL / identifier (KEK).
   */
  keyIdentifier?: string;

  /**
   * The KeyVault resource id for key (KEK).
   */
  kekKeyVaultArmId?: string;

  /**
   * The failover name for the managed disk.
   */
  failoverDiskName?: string;

  /**
   * The test failover name for the managed disk.
   */
  tfoDiskName?: string;
}

/**
 * A2A provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AProtectionContainerMappingDetails
  extends ProtectionContainerMappingProviderSpecificDetails {
  /**
   * A value indicating whether the auto update is enabled.
   */
  agentAutoUpdateStatus?: AgentAutoUpdateStatus;

  /**
   * The automation account arm id.
   */
  automationAccountArmId?: string;

  /**
   * A value indicating the type authentication to use for automation Account.
   */
  automationAccountAuthenticationType?: AutomationAccountAuthenticationType = "RunAsAccount";

  /**
   * The schedule arm name.
   */
  scheduleName?: string;

  /**
   * The job schedule arm name.
   */
  jobScheduleName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "A2A";
}

/**
 * A2A provider specific recovery point details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ARecoveryPointDetails extends ProviderSpecificRecoveryPointDetails {
  /**
   * A value indicating whether the recovery point is multi VM consistent.
   */
  recoveryPointSyncType?: RecoveryPointSyncType;

  /**
   * List of disk ids representing a recovery point.
   */
  disks?: string[];

  /**
   * Gets the provider type.
   */
  instanceType: "A2A";
}

/**
 * A2A remove disk(s) input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ARemoveDisksInput extends RemoveDisksProviderSpecificInput {
  /**
   * The list of vm disk vhd URIs.
   */
  vmDisksUris?: string[];

  /**
   * The list of vm managed disk Ids.
   */
  vmManagedDisksIds?: string[];

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AReplicationDetails extends ReplicationProviderSpecificSettings {
  /**
   * The fabric specific object Id of the virtual machine.
   */
  fabricObjectId?: string;

  /**
   * The initial primary availability zone.
   */
  @visibility(Lifecycle.Read)
  initialPrimaryZone?: string;

  /**
   * The initial primary fabric location.
   */
  @visibility(Lifecycle.Read)
  initialPrimaryFabricLocation?: string;

  /**
   * The initial recovery availability zone.
   */
  @visibility(Lifecycle.Read)
  initialRecoveryZone?: string;

  /**
   * The initial primary extended location.
   */
  initialPrimaryExtendedLocation?: ExtendedLocation;

  /**
   * The initial recovery extended location.
   */
  initialRecoveryExtendedLocation?: ExtendedLocation;

  /**
   * The initial recovery fabric location.
   */
  @visibility(Lifecycle.Read)
  initialRecoveryFabricLocation?: string;

  /**
   * The multi vm group Id.
   */
  multiVmGroupId?: string;

  /**
   * The multi vm group name.
   */
  multiVmGroupName?: string;

  /**
   * Whether Multi VM group is auto created or specified by user.
   */
  multiVmGroupCreateOption?: MultiVmGroupCreateOption;

  /**
   * The management Id.
   */
  managementId?: string;

  /**
   * The replication protection cluster Id.
   */
  protectionClusterId?: string;

  /**
   * A value indicating if the cluster infra is ready or not.
   */
  isClusterInfraReady?: boolean;

  /**
   * The list of protected disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedDisks?: A2AProtectedDiskDetails[];

  /**
   * The list of unprotected disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  unprotectedDisks?: A2AUnprotectedDiskDetails[];

  /**
   * The list of protected managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedManagedDisks?: A2AProtectedManagedDiskDetails[];

  /**
   * The recovery boot diagnostic storage account Arm Id.
   */
  recoveryBootDiagStorageAccountId?: string;

  /**
   * Primary fabric location.
   */
  primaryFabricLocation?: string;

  /**
   * The recovery fabric location.
   */
  recoveryFabricLocation?: string;

  /**
   * The type of operating system.
   */
  osType?: string;

  /**
   * The size of recovery virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryAzureVMSize?: string;

  /**
   * The name of recovery virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryAzureVMName?: string;

  /**
   * The recovery resource group.
   */
  recoveryAzureResourceGroupId?: string;

  /**
   * The recovery cloud service.
   */
  recoveryCloudService?: string;

  /**
   * The recovery availability set.
   */
  recoveryAvailabilitySet?: string;

  /**
   * The recovery virtual network.
   */
  selectedRecoveryAzureNetworkId?: string;

  /**
   * The test failover virtual network.
   */
  selectedTfoAzureNetworkId?: string;

  /**
   * The virtual machine nic details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMNicDetails[];

  /**
   * The synced configuration details.
   */
  vmSyncedConfigDetails?: AzureToAzureVmSyncedConfigDetails;

  /**
   * The percentage of the monitoring job. The type of the monitoring job is defined by MonitoringJobType property.
   */
  monitoringPercentageCompletion?: int32;

  /**
   * The type of the monitoring job. The progress is contained in MonitoringPercentageCompletion property.
   */
  monitoringJobType?: string;

  /**
   * The last heartbeat received from the source server.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * The agent version.
   */
  agentVersion?: string;

  /**
   * Agent expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentExpiryDate?: utcDateTime;

  /**
   * A value indicating whether replication agent update is required.
   */
  isReplicationAgentUpdateRequired?: boolean;

  /**
   * Agent certificate expiry date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentCertificateExpiryDate?: utcDateTime;

  /**
   * A value indicating whether agent certificate update is required.
   */
  isReplicationAgentCertificateUpdateRequired?: boolean;

  /**
   * The recovery fabric object Id.
   */
  recoveryFabricObjectId?: string;

  /**
   * The protection state for the vm.
   */
  vmProtectionState?: string;

  /**
   * The protection state description for the vm.
   */
  vmProtectionStateDescription?: string;

  /**
   * An id associated with the PE that survives actions like switch protection which change the backing PE/CPE objects internally.The lifecycle id gets carried forward to have a link/continuity in being able to have an Id that denotes the "same" protected item even though other internal Ids/ARM Id might be changing.
   */
  lifecycleId?: string;

  /**
   * The test failover fabric object Id.
   */
  testFailoverRecoveryFabricObjectId?: string;

  /**
   * The last RPO value in seconds.
   */
  rpoInSeconds?: int64;

  /**
   * The time (in UTC) when the last RPO value was calculated by Protection Service.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The primary availability zone.
   */
  primaryAvailabilityZone?: string;

  /**
   * The recovery availability zone.
   */
  recoveryAvailabilityZone?: string;

  /**
   * The primary Extended Location.
   */
  primaryExtendedLocation?: ExtendedLocation;

  /**
   * The recovery Extended Location.
   */
  recoveryExtendedLocation?: ExtendedLocation;

  /**
   * The encryption type of the VM.
   */
  @visibility(Lifecycle.Read)
  vmEncryptionType?: VmEncryptionType;

  /**
   * The test failover vm name.
   */
  tfoAzureVMName?: string;

  /**
   * The recovery azure generation.
   */
  @visibility(Lifecycle.Read)
  recoveryAzureGeneration?: string;

  /**
   * The recovery proximity placement group Id.
   */
  recoveryProximityPlacementGroupId?: string;

  /**
   * A value indicating whether the auto protection is enabled.
   */
  autoProtectionOfDataDisk?: AutoProtectionOfDataDisk;

  /**
   * The recovery virtual machine scale set id.
   */
  recoveryVirtualMachineScaleSetId?: string;

  /**
   * The recovery capacity reservation group Id.
   */
  recoveryCapacityReservationGroupId?: string;

  /**
   * A value indicating the churn option selected by user.
   */
  @visibility(Lifecycle.Read)
  churnOptionSelected?: ChurnOptionSelected;

  /**
   * The agent version to which last agent reinstall was attempted.
   */
  agentReinstallAttemptToVersion?: string;

  /**
   * The OS family name.
   */
  osFamilyName?: string;

  /**
   * The distro name.
   */
  distroName?: string;

  /**
   * The agent os name last agent reinstall was attempted.
   */
  distroNameForWhichAgentIsInstalled?: string;

  /**
   * A value indicating whether replication agent upgradeable.
   */
  isAgentUpgradeable?: boolean;

  /**
   * A value indicating whether replication agent reinstallation is required.
   */
  isAgentReinstallRequired?: boolean;

  /**
   * value for reason blocking reinstall.
   */
  reasonsBlockingReInstall?: string;

  /**
   * whether reinstall is possible or not.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reasonsBlockingReinstallDetails?: A2AAgentReinstallBlockingErrorDetails[];

  /**
   * A value indicating whether replication agent Upgrade is In-Progress.
   */
  isAgentUpgradeInProgress?: boolean;

  /**
   * auto agent upgrade retry count.
   */
  autoAgentUpgradeRetryCount?: int64;

  /**
   * A value indicating whether replication agent Upgrade retry exhausted.
   */
  isAgentUpgradeRetryThresholdExhausted?: boolean;

  /**
   * the platform fault domain.
   */
  platformFaultDomain?: int32;

  /**
   * Gets the Instance type.
   */
  instanceType: "A2A";
}

/**
 * A2A unprotected disk details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AUnprotectedDiskDetails {
  /**
   * The source lun Id for the data disk.
   */
  diskLunId?: int32;

  /**
   * A value indicating whether the disk auto protection is enabled.
   */
  diskAutoProtectionStatus?: AutoProtectionOfDataDisk;
}

/**
 * Hyper V VM network details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMNicDetails {
  /**
   * The nic Id.
   */
  nicId?: string;

  /**
   * The replica nic Id.
   */
  replicaNicId?: string;

  /**
   * The source nic ARM Id.
   */
  sourceNicArmId?: string;

  /**
   * VM network name.
   */
  vMNetworkName?: string;

  /**
   * Recovery VM network Id.
   */
  recoveryVMNetworkId?: string;

  /**
   * The IP configurations of the NIC.
   */
  ipConfigs?: IPConfigDetails[];

  /**
   * Selection type for failover.
   */
  selectionType?: string;

  /**
   * The id of the NSG associated with the NIC.
   */
  recoveryNetworkSecurityGroupId?: string;

  /**
   * A value indicating whether the NIC has accelerated networking enabled.
   */
  enableAcceleratedNetworkingOnRecovery?: boolean;

  /**
   * The network to be used by NIC during test failover.
   */
  tfoVMNetworkId?: string;

  /**
   * The NSG to be used by NIC during test failover.
   */
  tfoNetworkSecurityGroupId?: string;

  /**
   * Whether the TFO NIC has accelerated networking enabled.
   */
  enableAcceleratedNetworkingOnTfo?: boolean;

  /**
   * The name of the NIC to be used when creating target NICs.
   */
  recoveryNicName?: string;

  /**
   * The resource group of the NIC to be used when creating target NICs.
   */
  recoveryNicResourceGroupName?: string;

  /**
   * A value indicating whether an existing NIC is allowed to be reused during failover subject to availability.
   */
  reuseExistingNic?: boolean = false;

  /**
   * The name of the NIC to be used when creating target NICs in TFO.
   */
  tfoRecoveryNicName?: string;

  /**
   * The resource group of the NIC to be used when creating target NICs in TFO.
   */
  tfoRecoveryNicResourceGroupName?: string;

  /**
   * A value indicating whether an existing NIC is allowed to be reused during test failover subject to availability.
   */
  tfoReuseExistingNic?: boolean = false;

  /**
   * Target NIC name.
   */
  targetNicName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IPConfigDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isPrimary?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subnetName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  staticIPAddress?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipAddressType?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isSeletedForFailover?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoverySubnetName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryStaticIPAddress?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryIPAddressType?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPublicIPAddressId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryLBBackendAddressPoolIds?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tfoSubnetName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tfoStaticIPAddress?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tfoPublicIPAddressId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tfoLBBackendAddressPoolIds?: string[];
}

/**
 * Azure to Azure VM synced configuration details.
 */
model AzureToAzureVmSyncedConfigDetails {
  /**
   * The Azure VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The Azure VM input endpoints.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  inputEndpoints?: InputEndpoint[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InputEndpoint {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpointName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privatePort?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicPort?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protocol?: string;
}

/**
 * A2A provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AReplicationIntentDetails
  extends ReplicationProtectionIntentProviderSpecificSettings {
  /**
   * The fabric specific object Id of the virtual machine.
   */
  fabricObjectId?: string;

  /**
   * The primary location for the virtual machine.
   */
  primaryLocation?: string;

  /**
   * The recovery location for the virtual machine.
   */
  recoveryLocation?: string;

  /**
   * The recovery subscription Id of the virtual machine.
   */
  recoverySubscriptionId?: string;

  /**
   * The list of vm disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: A2AProtectionIntentDiskInputDetails[];

  /**
   * The list of vm managed disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmManagedDisks?: A2AProtectionIntentManagedDiskInputDetails[];

  /**
   * The recovery resource group id.
   */
  recoveryResourceGroupId?: string;

  /**
   * The protection profile custom details.
   */
  protectionProfile?: ProtectionProfileCustomDetails;

  /**
   * The primary staging storage account details.
   */
  primaryStagingStorageAccount?: StorageAccountCustomDetails;

  /**
   * The recovery availability set details.
   */
  recoveryAvailabilitySet?: RecoveryAvailabilitySetCustomDetails;

  /**
   * The recovery virtual network details.
   */
  recoveryVirtualNetwork?: RecoveryVirtualNetworkCustomDetails;

  /**
   * The recovery proximity placement group custom details.
   */
  recoveryProximityPlacementGroup?: RecoveryProximityPlacementGroupCustomDetails;

  /**
   * A value indicating whether the auto protection is enabled.
   */
  autoProtectionOfDataDisk?: AutoProtectionOfDataDisk;

  /**
   * The multi vm group name.
   */
  multiVmGroupName?: string;

  /**
   * The multi vm group id.
   */
  multiVmGroupId?: string;

  /**
   * The boot diagnostic storage account.
   */
  recoveryBootDiagStorageAccount?: StorageAccountCustomDetails;

  /**
   * The recovery disk encryption information (for two pass flows).
   */
  diskEncryptionInfo?: DiskEncryptionInfo;

  /**
   * The recovery availability zone.
   */
  recoveryAvailabilityZone?: string;

  /**
   * The recovery availability type of the virtual machine.
   */
  recoveryAvailabilityType: string;

  /**
   * A value indicating whether the auto update is enabled.
   */
  agentAutoUpdateStatus?: AgentAutoUpdateStatus;

  /**
   * The automation account arm id.
   */
  automationAccountArmId?: string;

  /**
   * A value indicating the type authentication to use for automation Account.
   */
  automationAccountAuthenticationType?: AutomationAccountAuthenticationType = "RunAsAccount";

  /**
   * Gets the Instance type.
   */
  instanceType: "A2A";
}

/**
 * A2A provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AReplicationProtectionClusterDetails
  extends ReplicationClusterProviderSpecificSettings {
  /**
   * The multi vm group Id.
   */
  multiVmGroupId?: string;

  /**
   * The multi vm group name.
   */
  multiVmGroupName?: string;

  /**
   * Whether Multi VM group is auto created or specified by user.
   */
  multiVmGroupCreateOption?: MultiVmGroupCreateOption;

  /**
   * Primary fabric location.
   */
  primaryFabricLocation?: string;

  /**
   * The recovery fabric location.
   */
  recoveryFabricLocation?: string;

  /**
   * The recovery point Id to which the cluster was failed over.
   */
  failoverRecoveryPointId?: string;

  /**
   * The cluster management Id.
   */
  clusterManagementId?: string;

  /**
   * The last RPO value in seconds.
   */
  rpoInSeconds?: int64;

  /**
   * The time (in UTC) when the last RPO value was calculated by Protection Service.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The initial primary availability zone.
   */
  initialPrimaryZone?: string;

  /**
   * The initial primary fabric location.
   */
  initialPrimaryFabricLocation?: string;

  /**
   * The initial recovery availability zone.
   */
  initialRecoveryZone?: string;

  /**
   * The initial recovery fabric location.
   */
  initialRecoveryFabricLocation?: string;

  /**
   * The initial primary extended location.
   */
  initialPrimaryExtendedLocation?: ExtendedLocation;

  /**
   * The initial recovery extended location.
   */
  initialRecoveryExtendedLocation?: ExtendedLocation;

  /**
   * The primary availability zone.
   */
  primaryAvailabilityZone?: string;

  /**
   * The recovery availability zone.
   */
  recoveryAvailabilityZone?: string;

  /**
   * The primary Extended Location.
   */
  primaryExtendedLocation?: ExtendedLocation;

  /**
   * The recovery Extended Location.
   */
  recoveryExtendedLocation?: ExtendedLocation;

  /**
   * An id that survives actions like switch protection which change the backing PE/CPE objects internally.The lifecycle id gets carried forward to have a link/continuity in being able to have an Id that denotes the "same" protected cluster even though other internal Ids/ARM Id might be changing.
   */
  lifecycleId?: string;

  /**
   * Gets the Instance type.
   */
  instanceType: "A2A";
}

/**
 * Azure specific reprotect input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AReprotectInput extends ReverseReplicationProviderSpecificInput {
  /**
   * The recovery container Id.
   */
  recoveryContainerId?: string;

  /**
   * The list of vm disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: A2AVmDiskInputDetails[];

  /**
   * The recovery resource group Id. Valid for V2 scenarios.
   */
  recoveryResourceGroupId?: string;

  /**
   * The recovery cloud service Id. Valid for V1 scenarios.
   */
  recoveryCloudServiceId?: string;

  /**
   * The recovery availability set.
   */
  recoveryAvailabilitySetId?: string;

  /**
   * The Policy Id.
   */
  policyId?: string;

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * Extended location of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ASharedDiskIRErrorDetails {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * The error code enum.
   */
  @visibility(Lifecycle.Read)
  errorCodeEnum?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * The possible causes.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * The recommended action.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;
}

/**
 * A2A provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ASharedDiskReplicationDetails
  extends SharedDiskReplicationProviderSpecificSettings {
  /**
   * The management Id.
   */
  managementId?: string;

  /**
   * The list of unprotected disks.
   */
  @identifiers(#["diskLunId"])
  unprotectedDisks?: A2AUnprotectedDiskDetails[];

  /**
   * The list of protected managed disks.
   */
  @identifiers(#["diskId"])
  protectedManagedDisks?: A2AProtectedManagedDiskDetails[];

  /**
   * Primary fabric location.
   */
  primaryFabricLocation?: string;

  /**
   * The recovery fabric location.
   */
  recoveryFabricLocation?: string;

  /**
   * The recovery point id to which the Virtual node was failed over.
   */
  failoverRecoveryPointId?: string;

  /**
   * The percentage of the monitoring job. The type of the monitoring job is defined by MonitoringJobType property.
   */
  monitoringPercentageCompletion?: int32;

  /**
   * The type of the monitoring job. The progress is contained in MonitoringPercentageCompletion property.
   */
  monitoringJobType?: string;

  /**
   * The last RPO value in seconds.
   */
  rpoInSeconds?: int64;

  /**
   * The time (in UTC) when the last RPO value was calculated by Protection Service.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The IR Errors.
   */
  @identifiers(#["errorCode"])
  sharedDiskIRErrors?: A2ASharedDiskIRErrorDetails[];

  /**
   * Gets the Instance type.
   */
  instanceType: "A2A";
}

/**
 * A2A specific switch cluster protection input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ASwitchClusterProtectionInput
  extends SwitchClusterProtectionProviderSpecificInput {
  /**
   * The recovery container Id.
   */
  recoveryContainerId?: string;

  /**
   * The Policy Id.
   */
  policyId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["replicationProtectedItemName"])
  protectedItemsDetail?: A2AProtectedItemDetail[];

  /**
   * Gets the Instance type.
   */
  instanceType: "A2A";
}

/**
 * A2A specific switch protection input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ASwitchProtectionInput extends SwitchProtectionProviderSpecificInput {
  /**
   * The recovery container Id.
   */
  recoveryContainerId?: string;

  /**
   * The list of vm disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: A2AVmDiskInputDetails[];

  /**
   * The list of vm managed disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmManagedDisks?: A2AVmManagedDiskInputDetails[];

  /**
   * The recovery resource group Id. Valid for V2 scenarios.
   */
  recoveryResourceGroupId?: string;

  /**
   * The recovery cloud service Id. Valid for V1 scenarios.
   */
  recoveryCloudServiceId?: string;

  /**
   * The recovery availability set.
   */
  recoveryAvailabilitySetId?: string;

  /**
   * The Policy Id.
   */
  policyId?: string;

  /**
   * The boot diagnostic storage account.
   */
  recoveryBootDiagStorageAccountId?: string;

  /**
   * The recovery availability zone.
   */
  recoveryAvailabilityZone?: string;

  /**
   * The recovery proximity placement group Id.
   */
  recoveryProximityPlacementGroupId?: string;

  /**
   * The virtual machine scale set id.
   */
  recoveryVirtualMachineScaleSetId?: string;

  /**
   * The recovery capacity reservation group Id.
   */
  recoveryCapacityReservationGroupId?: string;

  /**
   * the platform fault domain.
   */
  platformFaultDomain?: int32;

  /**
   * The recovery disk encryption information.
   */
  diskEncryptionInfo?: DiskEncryptionInfo;

  /**
   * Gets the Instance type.
   */
  instanceType: "A2A";
}

/**
 * A2A provider specific input for test failover.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2ATestFailoverInput extends TestFailoverProviderSpecificInput {
  /**
   * The recovery point id to be passed to test failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * A value indicating whether to use recovery cloud service for TFO or not.
   */
  cloudServiceCreationOption?: string;

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A provider specific input for unplanned failover.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AUnplannedFailoverInput extends UnplannedFailoverProviderSpecificInput {
  /**
   * The recovery point id to be passed to failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * A value indicating whether to use recovery cloud service for failover or not.
   */
  cloudServiceCreationOption?: string;

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A update protection container mapping.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AUpdateContainerMappingInput
  extends ReplicationProviderSpecificUpdateContainerMappingInput {
  /**
   * A value indicating whether the auto update is enabled.
   */
  agentAutoUpdateStatus?: AgentAutoUpdateStatus;

  /**
   * The automation account arm id.
   */
  automationAccountArmId?: string;

  /**
   * A value indicating the type authentication to use for automation Account.
   */
  automationAccountAuthenticationType?: AutomationAccountAuthenticationType = "RunAsAccount";

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * InMage Azure V2 input to update replication protected item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AUpdateReplicationProtectedItemInput
  extends UpdateReplicationProtectedItemProviderInput {
  /**
   * The target cloud service ARM Id (for V1).
   */
  recoveryCloudServiceId?: string;

  /**
   * The target resource group ARM Id (for V2).
   */
  recoveryResourceGroupId?: string;

  /**
   * Managed disk update details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managedDiskUpdateDetails?: A2AVmManagedDiskUpdateDetails[];

  /**
   * The boot diagnostic storage account.
   */
  recoveryBootDiagStorageAccountId?: string;

  /**
   * The recovery os disk encryption information.
   */
  diskEncryptionInfo?: DiskEncryptionInfo;

  /**
   * The user given name for Test Failover VM.
   */
  tfoAzureVMName?: string;

  /**
   * The recovery proximity placement group Id.
   */
  recoveryProximityPlacementGroupId?: string;

  /**
   * The recovery virtual machine scale set Id.
   */
  recoveryVirtualMachineScaleSetId?: string;

  /**
   * The recovery capacity reservation group Id.
   */
  recoveryCapacityReservationGroupId?: string;

  /**
   * The recovery availability zone.
   */
  recoveryAvailabilityZone?: string;

  /**
   * The platform fault domain.
   */
  platformFaultDomain?: int32;

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * A2A Vm managed disk update details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AVmManagedDiskUpdateDetails {
  /**
   * The disk Id.
   */
  diskId?: string;

  /**
   * The target disk type before failover.
   */
  recoveryTargetDiskAccountType?: string;

  /**
   * The replica disk type before failover.
   */
  recoveryReplicaDiskAccountType?: string;

  /**
   * The recovery os disk encryption information.
   */
  diskEncryptionInfo?: DiskEncryptionInfo;

  /**
   * The target disk name for unplanned failover operation.
   */
  failoverDiskName?: string;

  /**
   * The target disk name for test failover operation.
   */
  tfoDiskName?: string;
}

/**
 * Zone details data.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model A2AZoneDetails {
  /**
   * Source zone info.
   */
  source?: string;

  /**
   * The target zone info.
   */
  target?: string;
}

/**
 * Agent details.
 */
model AgentDetails {
  /**
   * The Id of the agent running on the server.
   */
  @visibility(Lifecycle.Read)
  agentId?: string;

  /**
   * The Id of the machine to which the agent is registered.
   */
  @visibility(Lifecycle.Read)
  machineId?: string;

  /**
   * The machine BIOS Id.
   */
  @visibility(Lifecycle.Read)
  biosId?: string;

  /**
   * The machine FQDN.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  disks?: AgentDiskDetails[];
}

/**
 * Agent disk details.
 */
model AgentDiskDetails {
  /**
   * The disk Id.
   */
  @visibility(Lifecycle.Read)
  diskId?: string;

  /**
   * The disk name.
   */
  @visibility(Lifecycle.Read)
  diskName?: string;

  /**
   * A value indicating whether the disk is the OS disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  isOSDisk?: string;

  /**
   * The disk capacity in bytes.
   */
  @visibility(Lifecycle.Read)
  capacityInBytes?: int64;

  /**
   * The lun of disk.
   */
  @visibility(Lifecycle.Read)
  lunId?: int32;
}

/**
 * Appliance details of the migration item.
 */
model ApplianceMonitoringDetails {
  /**
   * The appliance CPU details.
   */
  @visibility(Lifecycle.Read)
  cpuDetails?: ApplianceResourceDetails;

  /**
   * The appliance RAM details.
   */
  @visibility(Lifecycle.Read)
  ramDetails?: ApplianceResourceDetails;

  /**
   * The appliance datastore snapshot details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  datastoreSnapshot?: DataStoreUtilizationDetails[];

  /**
   * The disk replication details.
   */
  @visibility(Lifecycle.Read)
  disksReplicationDetails?: ApplianceResourceDetails;

  /**
   * The ESXi NFC buffer details.
   */
  @visibility(Lifecycle.Read)
  esxiNfcBuffer?: ApplianceResourceDetails;

  /**
   * The appliance network bandwidth details.
   */
  @visibility(Lifecycle.Read)
  networkBandwidth?: ApplianceResourceDetails;
}

/**
 * Details of the appliance resource.
 */
model ApplianceResourceDetails {
  /**
   * A value indicating the total capacity of appliance resource.
   */
  @visibility(Lifecycle.Read)
  capacity?: int64;

  /**
   * A value indicating the utilization percentage by gateway agent on appliance.
   */
  @visibility(Lifecycle.Read)
  processUtilization?: float64;

  /**
   * A value indicating the total utilization percentage for all processes on the appliance.
   */
  @visibility(Lifecycle.Read)
  totalUtilization?: float64;

  /**
   * A value indicating the status of appliance resource.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Details of the appliance resource.
 */
model DataStoreUtilizationDetails {
  /**
   * The total count of snapshots supported by the datastore.
   */
  @visibility(Lifecycle.Read)
  totalSnapshotsSupported?: int64;

  /**
   * The total snapshots created for server migration in the datastore.
   */
  @visibility(Lifecycle.Read)
  totalSnapshotsCreated?: int64;

  /**
   * The datastore name.
   */
  @visibility(Lifecycle.Read)
  dataStoreName?: string;
}

/**
 * Query parameter to get appliance.
 */
model ApplianceQueryParameter {
  /**
   * The providerType to be used for fetching appliance details.
   */
  providerType?: string;
}

/**
 * This class represents job details based on specific job type.
 */
model AsrJobDetails extends JobDetails {
  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  instanceType: "AsrJobDetails";
}

/**
 * This class represents the task details for an automation runbook.
 */
model AutomationRunbookTaskDetails extends TaskTypeDetails {
  /**
   * The recovery plan task name.
   */
  name?: string;

  /**
   * The cloud service of the automation runbook account.
   */
  cloudServiceName?: string;

  /**
   * The subscription Id of the automation runbook account.
   */
  subscriptionId?: string;

  /**
   * The automation account name of the runbook.
   */
  accountName?: string;

  /**
   * The runbook Id.
   */
  runbookId?: string;

  /**
   * The runbook name.
   */
  runbookName?: string;

  /**
   * The job Id of the runbook execution.
   */
  jobId?: string;

  /**
   * The execution output of the runbook.
   */
  jobOutput?: string;

  /**
   * A value indicating whether it is a primary side script or not.
   */
  isPrimarySideScript?: boolean;

  /**
   * The type of task details.
   */
  instanceType: "AutomationRunbookTaskDetails";
}

/**
 * Fabric provider specific settings.
 */
model AzureFabricCreationInput extends FabricSpecificCreationInput {
  /**
   * The Location.
   */
  location?: string;

  /**
   * Gets the class type.
   */
  instanceType: "Azure";
}

/**
 * Azure Fabric Specific Details.
 */
model AzureFabricSpecificDetails extends FabricSpecificDetails {
  /**
   * The Location for the Azure fabric.
   */
  location?: string;

  /**
   * The container Ids for the Azure fabric.
   */
  containerIds?: string[];

  /**
   * The zones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  zones?: A2AZoneDetails[];

  /**
   * The ExtendedLocations.
   */
  @identifiers(#[])
  extendedLocations?: A2AExtendedLocationDetails[];

  /**
   * The location details.
   */
  @identifiers(#[])
  locationDetails?: A2AFabricSpecificLocationDetails[];

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "Azure";
}

/**
 * Create network mappings input properties/behavior specific to Azure to Azure Network mapping.
 */
model AzureToAzureCreateNetworkMappingInput
  extends FabricSpecificCreateNetworkMappingInput {
  /**
   * The primary azure vnet Id.
   */
  primaryNetworkId: string;

  /**
   * The instance type.
   */
  instanceType: "AzureToAzure";
}

/**
 * A2A Network Mapping fabric specific settings.
 */
model AzureToAzureNetworkMappingSettings
  extends NetworkMappingFabricSpecificSettings {
  /**
   * The primary fabric location.
   */
  primaryFabricLocation?: string;

  /**
   * The recovery fabric location.
   */
  recoveryFabricLocation?: string;

  /**
   * Gets the Instance type.
   */
  instanceType: "AzureToAzure";
}

/**
 * Updates network mappings input.
 */
model AzureToAzureUpdateNetworkMappingInput
  extends FabricSpecificUpdateNetworkMappingInput {
  /**
   * The primary azure vnet Id.
   */
  primaryNetworkId?: string;

  /**
   * The instance type.
   */
  instanceType: "AzureToAzure";
}

/**
 * Disk details for E2A provider.
 */
model AzureVmDiskDetails {
  /**
   * VHD type.
   */
  vhdType?: string;

  /**
   * The VHD id.
   */
  vhdId?: string;

  /**
   * The disk resource id.
   */
  diskId?: string;

  /**
   * VHD name.
   */
  vhdName?: string;

  /**
   * Max side in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxSizeMB?: string;

  /**
   * Blob uri of the Azure disk.
   */
  targetDiskLocation?: string;

  /**
   * The target Azure disk name.
   */
  targetDiskName?: string;

  /**
   * Ordinal\LunId of the disk for the Azure VM.
   */
  lunId?: string;

  /**
   * The DiskEncryptionSet ARM ID.
   */
  diskEncryptionSetId?: string;

  /**
   * The custom target Azure disk name.
   */
  customTargetDiskName?: string;
}

/**
 * This class represents the details for a failover job of cluster.
 */
model ClusterFailoverJobDetails extends JobDetails {
  /**
   * The test VM details.
   */
  @identifiers(#["name"])
  protectedItemDetails?: FailoverReplicationProtectedItemDetails[];

  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  instanceType: "ClusterFailoverJobDetails";
}

/**
 * Failover details for a replication protected item.
 */
model FailoverReplicationProtectedItemDetails {
  /**
   * The name.
   */
  name?: string;

  /**
   * The friendly name.
   */
  friendlyName?: string;

  /**
   * The test Vm name.
   */
  testVmName?: string;

  /**
   * The test Vm friendly name.
   */
  testVmFriendlyName?: string;

  /**
   * The network connection status.
   */
  networkConnectionStatus?: string;

  /**
   * The network friendly name.
   */
  networkFriendlyName?: string;

  /**
   * The network subnet.
   */
  subnet?: string;

  /**
   * The recovery point Id.
   */
  recoveryPointId?: string;

  /**
   * The recovery point time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;
}

/**
 * This class represents details for switch cluster protection job.
 */
model ClusterSwitchProtectionJobDetails extends JobDetails {
  /**
   * ARM Id of the new replication protection cluster.
   */
  newReplicationProtectionClusterId?: string;

  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  instanceType: "ClusterSwitchProtectionJobDetails";
}

/**
 * This class represents the details for a test failover job of cluster.
 */
model ClusterTestFailoverJobDetails extends JobDetails {
  /**
   * The test failover status.
   */
  testFailoverStatus?: string;

  /**
   * The test failover comments.
   */
  comments?: string;

  /**
   * The test network name.
   */
  networkName?: string;

  /**
   * The test network friendly name.
   */
  networkFriendlyName?: string;

  /**
   * The test network type (see TestFailoverInput enum for possible values).
   */
  networkType?: string;

  /**
   * The test VM details.
   */
  protectedItemDetails?: FailoverReplicationProtectedItemDetails[];

  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  instanceType: "ClusterTestFailoverJobDetails";
}

/**
 * This class contains monitoring details of all the inconsistent Protected Entities in Vmm.
 */
model ConsistencyCheckTaskDetails extends TaskTypeDetails {
  /**
   * The list of inconsistent Vm details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDetails?: InconsistentVmDetails[];

  /**
   * The type of task details.
   */
  instanceType: "ConsistencyCheckTaskDetails";
}

/**
 * This class stores the monitoring details for consistency check of inconsistent Protected Entity.
 */
model InconsistentVmDetails {
  /**
   * The Vm name.
   */
  vmName?: string;

  /**
   * The Cloud name.
   */
  cloudName?: string;

  /**
   * The list of details regarding state of the Protected Entity in SRS and On prem.
   */
  details?: string[];

  /**
   * The list of error ids.
   */
  errorIds?: string[];
}

/**
 * The datastore details of the MT.
 */
model DataStore {
  /**
   * The symbolic name of data store.
   */
  symbolicName?: string;

  /**
   * The uuid of data store.
   */
  uuid?: string;

  /**
   * The capacity of data store in GBs.
   */
  capacity?: string;

  /**
   * The free space of data store in GBs.
   */
  freeSpace?: string;

  /**
   * The type of data store.
   */
  type?: string;
}

/**
 * Onprem disk details data.
 */
model DiskDetails {
  /**
   * The hard disk max size in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxSizeMB?: int64;

  /**
   * The type of the volume.
   */
  vhdType?: string;

  /**
   * The VHD Id.
   */
  vhdId?: string;

  /**
   * The VHD name.
   */
  vhdName?: string;
}

/**
 * Volume details.
 */
model DiskVolumeDetails {
  /**
   * The volume label.
   */
  label?: string;

  /**
   * The volume name.
   */
  name?: string;
}

/**
 * DRA details.
 */
model DraDetails {
  /**
   * The DRA Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The DRA name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The DRA Bios Id.
   */
  @visibility(Lifecycle.Read)
  biosId?: string;

  /**
   * The version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The last heartbeat received from the DRA.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The health.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  healthErrors?: HealthError[];

  /**
   * The count of protected items which are protected in forward direction.
   */
  @visibility(Lifecycle.Read)
  forwardProtectedItemCount?: int32;

  /**
   * The count of protected items which are protected in reverse direction.
   */
  @visibility(Lifecycle.Read)
  reverseProtectedItemCount?: int32;
}

/**
 * Implements the event query parameter.
 */
model EventQueryParameter {
  /**
   * The source id of the events to be queried.
   */
  eventCode?: string;

  /**
   * The severity of the events to be queried.
   */
  severity?: string;

  /**
   * The type of the events to be queried.
   */
  eventType?: string;

  /**
   * The affected object server id of the events to be queried.
   */
  fabricName?: string;

  /**
   * The affected object name of the events to be queried.
   */
  affectedObjectFriendlyName?: string;

  /**
   * The affected object correlationId for the events to be queried.
   */
  affectedObjectCorrelationId?: string;

  /**
   * The start time of the time range within which the events are to be queried.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the time range within which the events are to be queried.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

/**
 * Existing storage account input.
 */
model ExistingProtectionProfile extends ProtectionProfileCustomDetails {
  /**
   * The protection profile Arm Id. Throw error, if resource does not exists.
   */
  protectionProfileId: string;

  /**
   * The class type.
   */
  resourceType: "Existing";
}

/**
 * Existing recovery availability set input.
 */
model ExistingRecoveryAvailabilitySet
  extends RecoveryAvailabilitySetCustomDetails {
  /**
   * The recovery availability set Id. Will throw error, if resource does not exist.
   */
  recoveryAvailabilitySetId?: string;

  /**
   * The class type.
   */
  resourceType: "Existing";
}

/**
 * Existing recovery proximity placement group input.
 */
model ExistingRecoveryProximityPlacementGroup
  extends RecoveryProximityPlacementGroupCustomDetails {
  /**
   * The recovery proximity placement group Id. Will throw error, if resource does not exist.
   */
  recoveryProximityPlacementGroupId?: string;

  /**
   * The class type.
   */
  resourceType: "Existing";
}

/**
 * Existing recovery resource group input.
 */
model ExistingRecoveryRecoveryResourceGroup
  extends RecoveryResourceGroupCustomDetails {
  /**
   * The recovery resource group Id. Valid for V2 scenarios.
   */
  recoveryResourceGroupId?: string;

  /**
   * The class type.
   */
  resourceType: "Existing";
}

/**
 * Existing recovery virtual network input.
 */
model ExistingRecoveryVirtualNetwork
  extends RecoveryVirtualNetworkCustomDetails {
  /**
   * The recovery virtual network Id. Will throw error, if resource does not exist.
   */
  recoveryVirtualNetworkId: string;

  /**
   * The recovery subnet name.
   */
  recoverySubnetName?: string;

  /**
   * The class type.
   */
  resourceType: "Existing";
}

/**
 * Existing storage account input.
 */
model ExistingStorageAccount extends StorageAccountCustomDetails {
  /**
   * The storage account Arm Id. Throw error, if resource does not exists.
   */
  azureStorageAccountId: string;

  /**
   * The class type.
   */
  resourceType: "Existing";
}

/**
 * This class represents details for export jobs workflow.
 */
model ExportJobDetails extends JobDetails {
  /**
   * BlobUri of the exported jobs.
   */
  blobUri?: string;

  /**
   * The sas token to access blob.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sasToken?: string;

  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  instanceType: "ExportJobDetails";
}

/**
 * Query parameter to get fabric.
 */
model FabricQueryParameter {
  /**
   * A value indicating whether the zone to zone mappings are to be returned.
   */
  zoneToZoneMappings?: string;

  /**
   * A value indicating whether the Extended Location mappings are to be returned.
   */
  extendedLocationMappings?: string;

  /**
   * A value indicating whether the location details are to be returned.
   */
  locationDetails?: string;

  /**
   * A value indicating whether the agent details are to be fetched.
   */
  fetchAgentDetails?: string;

  /**
   * The BIOS Id to be used for fetching agent details.
   */
  biosId?: string;

  /**
   * The FQDN to be used for fetching agent details.
   */
  fqdn?: string;

  /**
   * The type of the discovered machine to be used for fetching agent details.
   */
  discoveryType?: string;

  /**
   * The OS type to be used for fetching agent details.
   */
  osType?: string;
}

/**
 * This class represents the fabric replication group task details.
 */
model FabricReplicationGroupTaskDetails extends TaskTypeDetails {
  /**
   * The skipped reason.
   */
  skippedReason?: string;

  /**
   * The skipped reason string.
   */
  skippedReasonString?: string;

  /**
   * The job entity.
   */
  jobTask?: JobEntity;

  /**
   * The type of task details.
   */
  instanceType: "FabricReplicationGroupTaskDetails";
}

/**
 * This class represents a task which is actually a workflow so that one can navigate to its individual drill down.
 */
model JobTaskDetails extends TaskTypeDetails {
  /**
   * The job entity.
   */
  jobTask?: JobEntity;

  instanceType: "JobTaskDetails";
}

/**
 * This class contains the minimal job details required to navigate to the desired drill down.
 */
model JobEntity {
  /**
   * The job id.
   */
  jobId?: string;

  /**
   * The job display name.
   */
  jobFriendlyName?: string;

  /**
   * The object id.
   */
  targetObjectId?: string;

  /**
   * The object name.
   */
  targetObjectName?: string;

  /**
   * The workflow affected object type.
   */
  targetInstanceType?: string;

  /**
   * The job name. Enum type ScenarioName.
   */
  jobScenarioName?: string;
}

/**
 * This class represents the details for a failover job.
 */
model FailoverJobDetails extends JobDetails {
  /**
   * The test VM details.
   */
  protectedItemDetails?: FailoverReplicationProtectedItemDetails[];

  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  instanceType: "FailoverJobDetails";
}

/**
 * Details of the gateway operation.
 */
model GatewayOperationDetails {
  /**
   * A value indicating the state of gateway operation.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * A value indicating the progress percentage of gateway operation.
   */
  @visibility(Lifecycle.Read)
  progressPercentage?: int32;

  /**
   * A value indicating the time elapsed for the operation in milliseconds.
   */
  @visibility(Lifecycle.Read)
  timeElapsed?: int64;

  /**
   * A value indicating the time remaining for the operation in milliseconds.
   */
  @visibility(Lifecycle.Read)
  timeRemaining?: int64;

  /**
   * A value indicating the upload speed in bytes per second.
   */
  @visibility(Lifecycle.Read)
  uploadSpeed?: int64;

  /**
   * A value indicating the ESXi host name.
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * A value indicating the datastore collection.
   */
  @visibility(Lifecycle.Read)
  dataStores?: string[];

  /**
   * A value indicating the VMware read throughput in bytes per second.
   */
  @visibility(Lifecycle.Read)
  vmwareReadThroughput?: int64;
}

/**
 * Hyper-V host details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVHostDetails {
  /**
   * The Hyper-V host Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The Hyper-V host name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The Mars agent version.
   */
  @visibility(Lifecycle.Read)
  marsAgentVersion?: string;
}

/**
 * Model class for event details of a HyperVReplica E2E event.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplica2012EventDetails extends EventProviderSpecificDetails {
  /**
   * The container friendly name.
   */
  containerName?: string;

  /**
   * The fabric friendly name.
   */
  fabricName?: string;

  /**
   * The remote container name.
   */
  remoteContainerName?: string;

  /**
   * The remote fabric name.
   */
  remoteFabricName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVReplica2012";
}

/**
 * Model class for event details of a HyperVReplica blue E2E event.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplica2012R2EventDetails extends EventProviderSpecificDetails {
  /**
   * The container friendly name.
   */
  containerName?: string;

  /**
   * The fabric friendly name.
   */
  fabricName?: string;

  /**
   * The remote container name.
   */
  remoteContainerName?: string;

  /**
   * The remote fabric name.
   */
  remoteFabricName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVReplica2012R2";
}

/**
 * ApplyRecoveryPoint input specific to HyperVReplicaAzure provider.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureApplyRecoveryPointInput
  extends ApplyRecoveryPointProviderSpecificInput {
  /**
   * The primary kek certificate pfx.
   */
  primaryKekCertificatePfx?: string;

  /**
   * The secondary kek certificate pfx.
   */
  secondaryKekCertificatePfx?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * Disk input details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureDiskInputDetails {
  /**
   * The DiskId.
   */
  diskId?: string;

  /**
   * The LogStorageAccountId.
   */
  logStorageAccountId?: string;

  /**
   * The disk type.
   */
  diskType?: DiskAccountType;

  /**
   * The DiskEncryptionSet ARM ID.
   */
  diskEncryptionSetId?: string;

  /**
   * The logical sector size (in bytes), 512 by default.
   */
  sectorSizeInBytes?: int32;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * HyperVReplicaAzure specific enable protection input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureEnableProtectionInput
  extends EnableProtectionProviderSpecificInput {
  /**
   * The Hyper-V host VM Id.
   */
  hvHostVmId?: string;

  /**
   * The VM Name.
   */
  vmName?: string;

  /**
   * The OS type associated with VM.
   */
  osType?: string;

  /**
   * The OS name selected by user.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userSelectedOSName?: string;

  /**
   * The OS disk VHD id associated with VM.
   */
  vhdId?: string;

  /**
   * The storage account Id.
   */
  targetStorageAccountId?: string;

  /**
   * The selected target Azure network Id.
   */
  targetAzureNetworkId?: string;

  /**
   * The selected target Azure subnet Id.
   */
  targetAzureSubnetId?: string;

  /**
   * The selected option to enable RDP\SSH on target vm after failover. String value of SrsDataContract.EnableRDPOnTargetOption enum.
   */
  enableRdpOnTargetOption?: string;

  /**
   * The target azure VM Name.
   */
  targetAzureVmName?: string;

  /**
   * The storage account to be used for logging during replication.
   */
  logStorageAccountId?: string;

  /**
   * The list of VHD Ids of disks to be protected.
   */
  disksToInclude?: string[];

  /**
   * The Id of the target resource group (for classic deployment) in which the failover VM is to be created.
   */
  targetAzureV1ResourceGroupId?: string;

  /**
   * The Id of the target resource group (for resource manager deployment) in which the failover VM is to be created.
   */
  targetAzureV2ResourceGroupId?: string;

  /**
   * A value indicating whether managed disks should be used during failover.
   */
  useManagedDisks?: string;

  /**
   * The target availability set ARM Id for resource manager deployment.
   */
  targetAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * License type.
   */
  licenseType?: LicenseType;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * The target VM security profile.
   */
  targetVmSecurityProfile?: SecurityProfileProperties;

  /**
   * The target VM size.
   */
  targetVmSize?: string;

  /**
   * The proximity placement group ARM Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * A value indicating whether managed disks should be used during replication.
   */
  useManagedDisksForReplication?: string;

  /**
   * The disk type.
   */
  diskType?: DiskAccountType;

  /**
   * The disks to include list for managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disksToIncludeForManagedDisks?: HyperVReplicaAzureDiskInputDetails[];

  /**
   * The DiskEncryptionSet ARM Id.
   */
  diskEncryptionSetId?: string;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The tags for the seed managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  seedManagedDiskTags?: Record<string>;

  /**
   * The tags for the target managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetManagedDiskTags?: Record<string>;

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * Security profile input.
 */
model SecurityProfileProperties {
  /**
   * The target VM security type.
   */
  targetVmSecurityType?: SecurityType;

  /**
   * A value indicating whether secure boot to be enabled.
   */
  targetVmSecureBoot?: SecurityConfiguration;

  /**
   * A value indicating whether trusted platform module to be enabled.
   */
  targetVmTpm?: SecurityConfiguration;

  /**
   * A value indicating whether integrity monitoring to be enabled.
   */
  targetVmMonitoring?: SecurityConfiguration;

  /**
   * A value indicating whether confidential compute encryption to be enabled.
   */
  targetVmConfidentialEncryption?: SecurityConfiguration;
}

/**
 * Model class for event details of a HyperVReplica E2A event.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureEventDetails extends EventProviderSpecificDetails {
  /**
   * The container friendly name.
   */
  containerName?: string;

  /**
   * The fabric friendly name.
   */
  fabricName?: string;

  /**
   * The remote container name.
   */
  remoteContainerName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * HyperVReplicaAzureFailback specific planned failover input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureFailbackProviderInput
  extends PlannedFailoverProviderSpecificFailoverInput {
  /**
   * Data sync option.
   */
  dataSyncOption?: string;

  /**
   * ALR options to create alternate recovery.
   */
  recoveryVmCreationOption?: string;

  /**
   * Provider Id for alternate location.
   */
  providerIdForAlternateRecovery?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzureFailback";
}

/**
 * Hyper-V Managed disk details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureManagedDiskDetails {
  /**
   * The disk Id.
   */
  diskId?: string;

  /**
   * Seed managed disk Id.
   */
  seedManagedDiskId?: string;

  /**
   * The replica disk type.
   */
  replicaDiskType?: string;

  /**
   * The disk encryption set ARM Id.
   */
  diskEncryptionSetId?: string;

  /**
   * The disk type.
   */
  targetDiskAccountType?: DiskAccountType;

  /**
   * The logical sector size (in bytes), 512 by default.
   */
  sectorSizeInBytes?: int32;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * HyperVReplicaAzure specific planned failover input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzurePlannedFailoverProviderInput
  extends PlannedFailoverProviderSpecificFailoverInput {
  /**
   * Primary kek certificate pfx.
   */
  primaryKekCertificatePfx?: string;

  /**
   * Secondary kek certificate pfx.
   */
  secondaryKekCertificatePfx?: string;

  /**
   * The recovery point id to be passed to failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  osUpgradeVersion?: string;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * Hyper-V Replica Azure specific protection profile details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzurePolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * The duration (in hours) to which point the recovery history needs to be maintained.
   */
  recoveryPointHistoryDurationInHours?: int32;

  /**
   * The interval (in hours) at which Hyper-V Replica should create an application consistent snapshot within the VM.
   */
  applicationConsistentSnapshotFrequencyInHours?: int32;

  /**
   * The replication interval.
   */
  replicationInterval?: int32;

  /**
   * The scheduled start time for the initial replication. If this parameter is Null, the initial replication starts immediately.
   */
  onlineReplicationStartTime?: string;

  /**
   * A value indicating whether encryption is enabled for virtual machines in this cloud.
   */
  encryption?: string;

  /**
   * The active storage account Id.
   */
  activeStorageAccountId?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * Hyper-V Replica Azure specific input for creating a protection profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzurePolicyInput extends PolicyProviderSpecificInput {
  /**
   * The duration (in hours) to which point the recovery history needs to be maintained.
   */
  recoveryPointHistoryDuration?: int32;

  /**
   * The interval (in hours) at which Hyper-V Replica should create an application consistent snapshot within the VM.
   */
  applicationConsistentSnapshotFrequencyInHours?: int32;

  /**
   * The replication interval.
   */
  replicationInterval?: int32;

  /**
   * The scheduled start time for the initial replication. If this parameter is Null, the initial replication starts immediately.
   */
  onlineReplicationStartTime?: string;

  /**
   * The list of storage accounts to which the VMs in the primary cloud can replicate to.
   */
  storageAccounts?: string[];

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * Hyper V Replica Azure provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureReplicationDetails
  extends ReplicationProviderSpecificSettings {
  /**
   * Azure VM Disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureVmDiskDetails?: AzureVmDiskDetails[];

  /**
   * Recovery Azure given name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryAzureVmName?: string;

  /**
   * The Recovery Azure VM size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryAzureVMSize?: string;

  /**
   * The recovery Azure storage account.
   */
  recoveryAzureStorageAccount?: string;

  /**
   * The ARM id of the log storage account used for replication. This will be set to null if no log storage account was provided during enable protection.
   */
  recoveryAzureLogStorageAccountId?: string;

  /**
   * The Last replication time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplicatedTime?: utcDateTime;

  /**
   * Last RPO value.
   */
  rpoInSeconds?: int64;

  /**
   * The last RPO calculated time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The virtual machine Id.
   */
  vmId?: string;

  /**
   * The protection state for the vm.
   */
  vmProtectionState?: string;

  /**
   * The protection state description for the vm.
   */
  vmProtectionStateDescription?: string;

  /**
   * Initial replication details.
   */
  initialReplicationDetails?: InitialReplicationDetails;

  /**
   * The PE Network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMNicDetails[];

  /**
   * The selected recovery azure network Id.
   */
  selectedRecoveryAzureNetworkId?: string;

  /**
   * The selected source nic Id which will be used as the primary nic during failover.
   */
  selectedSourceNicId?: string;

  /**
   * The encryption info.
   */
  encryption?: string;

  /**
   * The operating system info.
   */
  oSDetails?: OSDetails;

  /**
   * The RAM size of the VM on the primary side.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceVmRamSizeInMB?: int32;

  /**
   * The CPU count of the VM on the primary side.
   */
  sourceVmCpuCount?: int32;

  /**
   * The selected option to enable RDP\SSH on target vm after failover. String value of SrsDataContract.EnableRDPOnTargetOption enum.
   */
  enableRdpOnTargetOption?: string;

  /**
   * The target resource group Id.
   */
  recoveryAzureResourceGroupId?: string;

  /**
   * The recovery availability set Id.
   */
  recoveryAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target proximity placement group Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * A value indicating whether managed disks should be used during failover.
   */
  useManagedDisks?: string;

  /**
   * License Type of the VM to be used.
   */
  licenseType?: string;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: string;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * The last recovery point received time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The tags for the seed managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  seedManagedDiskTags?: Record<string>;

  /**
   * The tags for the target managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetManagedDiskTags?: Record<string>;

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The list of protected managed disks.
   */
  @identifiers(#[])
  protectedManagedDisks?: HyperVReplicaAzureManagedDiskDetails[];

  /**
   * A value indicating all available inplace OS Upgrade configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  allAvailableOSUpgradeConfigurations?: OSUpgradeSupportedVersions[];

  /**
   * The target VM security profile.
   */
  targetVmSecurityProfile?: SecurityProfileProperties;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * Gets the Instance type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * Initial replication details.
 */
model InitialReplicationDetails {
  /**
   * Initial replication type.
   */
  initialReplicationType?: string;

  /**
   * The initial replication progress percentage.
   */
  initialReplicationProgressPercentage?: string;
}

/**
 * Disk Details.
 */
model OSDetails {
  /**
   * VM Disk details.
   */
  osType?: string;

  /**
   * Product type.
   */
  productType?: string;

  /**
   * The OSEdition.
   */
  osEdition?: string;

  /**
   * The OS Version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  oSVersion?: string;

  /**
   * The OS Major Version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  oSMajorVersion?: string;

  /**
   * The OS Minor Version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  oSMinorVersion?: string;

  /**
   * The OS name selected by user.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userSelectedOSName?: string;
}

/**
 * Supported OS upgrade versions.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OSUpgradeSupportedVersions {
  /**
   * The source OS version name.
   */
  @visibility(Lifecycle.Read)
  supportedSourceOsVersion?: string;

  /**
   * The target OS version names.
   */
  @visibility(Lifecycle.Read)
  supportedTargetOsVersions?: string[];
}

/**
 * Azure specific reprotect input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureReprotectInput
  extends ReverseReplicationProviderSpecificInput {
  /**
   * The Hyper-V host Vm Id.
   */
  hvHostVmId?: string;

  /**
   * The Vm Name.
   */
  vmName?: string;

  /**
   * The OS type associated with vm.
   */
  osType?: string;

  /**
   * The OS disk VHD id associated with vm.
   */
  vHDId?: string;

  /**
   * The storage account name.
   */
  storageAccountId?: string;

  /**
   * The storage account to be used for logging during replication.
   */
  logStorageAccountId?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * HvrA provider specific input for test failover.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureTestFailoverInput
  extends TestFailoverProviderSpecificInput {
  /**
   * Primary kek certificate pfx.
   */
  primaryKekCertificatePfx?: string;

  /**
   * Secondary kek certificate pfx.
   */
  secondaryKekCertificatePfx?: string;

  /**
   * The recovery point id to be passed to test failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  osUpgradeVersion?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * HvrA provider specific input for unplanned failover.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureUnplannedFailoverInput
  extends UnplannedFailoverProviderSpecificInput {
  /**
   * Primary kek certificate pfx.
   */
  primaryKekCertificatePfx?: string;

  /**
   * Secondary kek certificate pfx.
   */
  secondaryKekCertificatePfx?: string;

  /**
   * The recovery point id to be passed to failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * HyperV replica Azure input to update replication protected item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaAzureUpdateReplicationProtectedItemInput
  extends UpdateReplicationProtectedItemProviderInput {
  /**
   * The recovery Azure resource group Id for classic deployment.
   */
  recoveryAzureV1ResourceGroupId?: string;

  /**
   * The recovery Azure resource group Id for resource manager deployment.
   */
  recoveryAzureV2ResourceGroupId?: string;

  /**
   * A value indicating whether managed disks should be used during failover.
   */
  useManagedDisks?: string;

  /**
   * The dictionary of disk resource Id to disk encryption set ARM Id.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskIdToDiskEncryptionMap?: Record<string>;

  /**
   * The target proximity placement group Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The tags for the target managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetManagedDiskTags?: Record<string>;

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * The OS name selected by user.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userSelectedOSName?: string;

  /**
   * The list of disk update properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: UpdateDiskInput[];

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * Disk input for update.
 */
model UpdateDiskInput {
  /**
   * The disk Id.
   */
  diskId: string;

  /**
   * The target disk name.
   */
  targetDiskName?: string;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * Abstract model class for event details of a HyperVReplica E2E event.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaBaseEventDetails extends EventProviderSpecificDetails {
  /**
   * The container friendly name.
   */
  containerName?: string;

  /**
   * The fabric friendly name.
   */
  fabricName?: string;

  /**
   * The remote container name.
   */
  remoteContainerName?: string;

  /**
   * The remote fabric name.
   */
  remoteFabricName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVReplicaBaseEventDetails";
}

/**
 * Base class for HyperVReplica policy details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaBasePolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * A value indicating the number of recovery points.
   */
  recoveryPoints?: int32;

  /**
   * A value indicating the application consistent frequency.
   */
  applicationConsistentSnapshotFrequencyInHours?: int32;

  /**
   * A value indicating whether compression has to be enabled.
   */
  compression?: string;

  /**
   * A value indicating whether IR is online.
   */
  initialReplicationMethod?: string;

  /**
   * A value indicating the online IR start time.
   */
  onlineReplicationStartTime?: string;

  /**
   * A value indicating the offline IR import path.
   */
  offlineReplicationImportPath?: string;

  /**
   * A value indicating the offline IR export path.
   */
  offlineReplicationExportPath?: string;

  /**
   * A value indicating the recovery HTTPS port.
   */
  replicationPort?: int32;

  /**
   * A value indicating the authentication type.
   */
  allowedAuthenticationType?: int32;

  /**
   * A value indicating whether the VM has to be auto deleted. Supported Values: String.Empty, None, OnRecoveryCloud.
   */
  replicaDeletionOption?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVReplicaBasePolicyDetails";
}

/**
 * Hyper V replica provider specific settings base class.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaBaseReplicationDetails
  extends ReplicationProviderSpecificSettings {
  /**
   * The Last replication time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplicatedTime?: utcDateTime;

  /**
   * The PE Network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMNicDetails[];

  /**
   * The virtual machine Id.
   */
  vmId?: string;

  /**
   * The protection state for the vm.
   */
  vmProtectionState?: string;

  /**
   * The protection state description for the vm.
   */
  vmProtectionStateDescription?: string;

  /**
   * Initial replication details.
   */
  initialReplicationDetails?: InitialReplicationDetails;

  /**
   * VM disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vMDiskDetails?: DiskDetails[];

  /**
   * Gets the Instance type.
   */
  instanceType: "HyperVReplicaBaseReplicationDetails";
}

/**
 * Hyper-V Replica Blue specific protection profile details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaBluePolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * A value indicating the replication interval.
   */
  replicationFrequencyInSeconds?: int32;

  /**
   * A value indicating the number of recovery points.
   */
  recoveryPoints?: int32;

  /**
   * A value indicating the application consistent frequency.
   */
  applicationConsistentSnapshotFrequencyInHours?: int32;

  /**
   * A value indicating whether compression has to be enabled.
   */
  compression?: string;

  /**
   * A value indicating whether IR is online.
   */
  initialReplicationMethod?: string;

  /**
   * A value indicating the online IR start time.
   */
  onlineReplicationStartTime?: string;

  /**
   * A value indicating the offline IR import path.
   */
  offlineReplicationImportPath?: string;

  /**
   * A value indicating the offline IR export path.
   */
  offlineReplicationExportPath?: string;

  /**
   * A value indicating the recovery HTTPS port.
   */
  replicationPort?: int32;

  /**
   * A value indicating the authentication type.
   */
  allowedAuthenticationType?: int32;

  /**
   * A value indicating whether the VM has to be auto deleted. Supported Values: String.Empty, None, OnRecoveryCloud
   */
  replicaDeletionOption?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVReplica2012R2";
}

/**
 * HyperV Replica Blue policy input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaBluePolicyInput extends PolicyProviderSpecificInput {
  /**
   * A value indicating the replication interval.
   */
  replicationFrequencyInSeconds?: int32;

  /**
   * A value indicating the number of recovery points.
   */
  recoveryPoints?: int32;

  /**
   * A value indicating the application consistent frequency.
   */
  applicationConsistentSnapshotFrequencyInHours?: int32;

  /**
   * A value indicating whether compression has to be enabled.
   */
  compression?: string;

  /**
   * A value indicating whether IR is online.
   */
  initialReplicationMethod?: string;

  /**
   * A value indicating the online IR start time.
   */
  onlineReplicationStartTime?: string;

  /**
   * A value indicating the offline IR import path.
   */
  offlineReplicationImportPath?: string;

  /**
   * A value indicating the offline IR export path.
   */
  offlineReplicationExportPath?: string;

  /**
   * A value indicating the recovery HTTPS port.
   */
  replicationPort?: int32;

  /**
   * A value indicating the authentication type.
   */
  allowedAuthenticationType?: int32;

  /**
   * A value indicating whether the VM has to be auto deleted.
   */
  replicaDeletion?: string;

  /**
   * The class type.
   */
  instanceType: "HyperVReplica2012R2";
}

/**
 * Hyper-V Replica specific policy Input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaPolicyInput extends PolicyProviderSpecificInput {
  /**
   * The class type.
   */
  instanceType: "HyperVReplica2012";

  /**
   * A value indicating the number of recovery points.
   */
  recoveryPoints?: int32;

  /**
   * A value indicating the application consistent frequency.
   */
  applicationConsistentSnapshotFrequencyInHours?: int32;

  /**
   * A value indicating whether compression has to be enabled.
   */
  compression?: string;

  /**
   * A value indicating whether IR is online.
   */
  initialReplicationMethod?: string;

  /**
   * A value indicating the online IR start time.
   */
  onlineReplicationStartTime?: string;

  /**
   * A value indicating the offline IR import path.
   */
  offlineReplicationImportPath?: string;

  /**
   * A value indicating the offline IR export path.
   */
  offlineReplicationExportPath?: string;

  /**
   * A value indicating the recovery HTTPS port.
   */
  replicationPort?: int32;

  /**
   * A value indicating the authentication type.
   */
  allowedAuthenticationType?: int32;

  /**
   * A value indicating whether the VM has to be auto deleted.
   */
  replicaDeletion?: string;
}

/**
 * HyperV replica 2012 R2 (Blue) replication details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaBlueReplicationDetails
  extends ReplicationProviderSpecificSettings {
  /**
   * The Last replication time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplicatedTime?: utcDateTime;

  /**
   * The PE Network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMNicDetails[];

  /**
   * The virtual machine Id.
   */
  vmId?: string;

  /**
   * The protection state for the vm.
   */
  vmProtectionState?: string;

  /**
   * The protection state description for the vm.
   */
  vmProtectionStateDescription?: string;

  /**
   * Initial replication details.
   */
  initialReplicationDetails?: InitialReplicationDetails;

  /**
   * VM disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vMDiskDetails?: DiskDetails[];

  /**
   * Gets the Instance type.
   */
  instanceType: "HyperVReplica2012R2";
}

/**
 * Hyper-V Replica Blue specific protection profile details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaPolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * A value indicating the number of recovery points.
   */
  recoveryPoints?: int32;

  /**
   * A value indicating the application consistent frequency.
   */
  applicationConsistentSnapshotFrequencyInHours?: int32;

  /**
   * A value indicating whether compression has to be enabled.
   */
  compression?: string;

  /**
   * A value indicating whether IR is online.
   */
  initialReplicationMethod?: string;

  /**
   * A value indicating the online IR start time.
   */
  onlineReplicationStartTime?: string;

  /**
   * A value indicating the offline IR import path.
   */
  offlineReplicationImportPath?: string;

  /**
   * A value indicating the offline IR export path.
   */
  offlineReplicationExportPath?: string;

  /**
   * A value indicating the recovery HTTPS port.
   */
  replicationPort?: int32;

  /**
   * A value indicating the authentication type.
   */
  allowedAuthenticationType?: int32;

  /**
   * A value indicating whether the VM has to be auto deleted. Supported Values: String.Empty, None, OnRecoveryCloud
   */
  replicaDeletionOption?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVReplica2012";
}

/**
 * HyperV replica 2012 replication details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVReplicaReplicationDetails
  extends ReplicationProviderSpecificSettings {
  /**
   * The Last replication time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplicatedTime?: utcDateTime;

  /**
   * The PE Network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMNicDetails[];

  /**
   * The virtual machine Id.
   */
  vmId?: string;

  /**
   * The protection state for the vm.
   */
  vmProtectionState?: string;

  /**
   * The protection state description for the vm.
   */
  vmProtectionStateDescription?: string;

  /**
   * Initial replication details.
   */
  initialReplicationDetails?: InitialReplicationDetails;

  /**
   * VM disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vMDiskDetails?: DiskDetails[];

  /**
   * Gets the Instance type.
   */
  instanceType: "HyperVReplica2012";
}

/**
 * HyperVSite fabric specific details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVSiteDetails extends FabricSpecificDetails {
  /**
   * The list of Hyper-V hosts associated with the fabric.
   */
  hyperVHosts?: HyperVHostDetails[];

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "HyperVSite";
}

/**
 * Single Host fabric provider specific VM settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HyperVVirtualMachineDetails extends ConfigurationSettings {
  /**
   * The source id of the object.
   */
  sourceItemId?: string;

  /**
   * The id of the object in fabric.
   */
  generation?: string;

  /**
   * The Last replication time.
   */
  osDetails?: OSDetails;

  /**
   * The Last successful failover time.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskDetails?: DiskDetails[];

  /**
   * A value indicating whether the VM has a physical disk attached. String value of SrsDataContract.PresenceStatus enum.
   */
  hasPhysicalDisk?: PresenceStatus;

  /**
   * A value indicating whether the VM has a fibre channel adapter attached. String value of SrsDataContract.PresenceStatus enum.
   */
  hasFibreChannelAdapter?: PresenceStatus;

  /**
   * A value indicating whether the VM has a shared VHD attached. String value of SrsDataContract.PresenceStatus enum.
   */
  hasSharedVhd?: PresenceStatus;

  /**
   * The Id of the hyper-v host in fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hyperVHostId?: string;

  instanceType: "HyperVVirtualMachine";
}

/**
 * This class represents the inline workflow task details.
 */
model InlineWorkflowTaskDetails extends GroupTaskDetails {
  /**
   * The list of child workflow ids.
   */
  workflowIds?: string[];

  /**
   * The type of task details.
   */
  instanceType: "InlineWorkflowTaskDetails";
}

/**
 * The details of the InMage agent.
 */
model InMageAgentDetails {
  /**
   * The agent version.
   */
  agentVersion?: string;

  /**
   * A value indicating whether installed agent needs to be updated.
   */
  agentUpdateStatus?: string;

  /**
   * A value indicating whether reboot is required after update is applied.
   */
  postUpdateRebootStatus?: string;

  /**
   * Agent expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentExpiryDate?: utcDateTime;
}

/**
 * ApplyRecoveryPoint input specific to InMageAzureV2 provider.
 */
model InMageAzureV2ApplyRecoveryPointInput
  extends ApplyRecoveryPointProviderSpecificInput {
  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * Disk input details.
 */
model InMageAzureV2DiskInputDetails {
  /**
   * The DiskId.
   */
  diskId?: string;

  /**
   * The LogStorageAccountId.
   */
  logStorageAccountId?: string;

  /**
   * The disk type.
   */
  diskType?: DiskAccountType;

  /**
   * The DiskEncryptionSet ARM ID.
   */
  diskEncryptionSetId?: string;
}

/**
 * VMware Azure specific enable protection input.
 */
model InMageAzureV2EnableProtectionInput
  extends EnableProtectionProviderSpecificInput {
  /**
   * The Master target Id.
   */
  masterTargetId?: string;

  /**
   * The Process Server Id.
   */
  processServerId?: string;

  /**
   * The storage account Id.
   */
  storageAccountId?: string;

  /**
   * The CS account Id.
   */
  runAsAccountId?: string;

  /**
   * The multi VM group Id.
   */
  multiVmGroupId?: string;

  /**
   * The multi VM group name.
   */
  multiVmGroupName?: string;

  /**
   * The disks to include list.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disksToInclude?: InMageAzureV2DiskInputDetails[];

  /**
   * The selected target Azure network Id.
   */
  targetAzureNetworkId?: string;

  /**
   * The selected target Azure subnet Id.
   */
  targetAzureSubnetId?: string;

  /**
   * The selected option to enable RDP\SSH on target VM after failover. String value of SrsDataContract.EnableRDPOnTargetOption enum.
   */
  enableRdpOnTargetOption?: string;

  /**
   * The target azure VM Name.
   */
  targetAzureVmName?: string;

  /**
   * The storage account to be used for logging during replication.
   */
  logStorageAccountId?: string;

  /**
   * The Id of the target resource group (for classic deployment) in which the failover VM is to be created.
   */
  targetAzureV1ResourceGroupId?: string;

  /**
   * The Id of the target resource group (for resource manager deployment) in which the failover VM is to be created.
   */
  targetAzureV2ResourceGroupId?: string;

  /**
   * The disk type.
   */
  diskType?: DiskAccountType;

  /**
   * The target availability set ARM Id for resource manager deployment.
   */
  targetAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The proximity placement group ARM Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * License type.
   */
  licenseType?: LicenseType;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * The target VM size.
   */
  targetVmSize?: string;

  /**
   * The DiskEncryptionSet ARM Id.
   */
  diskEncryptionSetId?: string;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The tags for the seed managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  seedManagedDiskTags?: Record<string>;

  /**
   * The tags for the target managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetManagedDiskTags?: Record<string>;

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * Model class for event details of a VMwareAzureV2 event.
 */
model InMageAzureV2EventDetails extends EventProviderSpecificDetails {
  /**
   * InMage Event type. Takes one of the values of InMageDataContract.InMageMonitoringEventType.
   */
  eventType?: string;

  /**
   * InMage Event Category.
   */
  category?: string;

  /**
   * InMage Event Component.
   */
  component?: string;

  /**
   * Corrective Action string for the event.
   */
  correctiveAction?: string;

  /**
   * InMage Event Details.
   */
  details?: string;

  /**
   * InMage Event Summary.
   */
  summary?: string;

  /**
   * VMware Site name.
   */
  siteName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageAzureV2";
}

/**
 * InMageAzureV2 Managed disk details.
 */
model InMageAzureV2ManagedDiskDetails {
  /**
   * The disk id.
   */
  diskId?: string;

  /**
   * Seed managed disk Id.
   */
  seedManagedDiskId?: string;

  /**
   * The replica disk type.
   */
  replicaDiskType?: string;

  /**
   * The DiskEncryptionSet ARM ID.
   */
  diskEncryptionSetId?: string;

  /**
   * The target disk name.
   */
  targetDiskName?: string;
}

/**
 * InMage Azure v2 specific protection profile details.
 */
model InMageAzureV2PolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * The crash consistent snapshot frequency in minutes.
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * The recovery point threshold in minutes.
   */
  recoveryPointThresholdInMinutes?: int32;

  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistory?: int32;

  /**
   * The app consistent snapshot frequency in minutes.
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled.
   */
  multiVmSyncStatus?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageAzureV2";
}

/**
 * VMWare Azure specific policy Input.
 */
model InMageAzureV2PolicyInput extends PolicyProviderSpecificInput {
  /**
   * The recovery point threshold in minutes.
   */
  recoveryPointThresholdInMinutes?: int32;

  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistory?: int32;

  /**
   * The crash consistent snapshot frequency (in minutes).
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * The app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled. Value should be 'Enabled' or 'Disabled'.
   */
  multiVmSyncStatus: SetMultiVmSyncStatus;

  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * InMageAzureV2 protected disk details.
 */
model InMageAzureV2ProtectedDiskDetails {
  /**
   * The disk id.
   */
  diskId?: string;

  /**
   * The disk name.
   */
  diskName?: string;

  /**
   * The protection stage.
   */
  protectionStage?: string;

  /**
   * The health error code for the disk.
   */
  healthErrorCode?: string;

  /**
   * The RPO in seconds.
   */
  rpoInSeconds?: int64;

  /**
   * A value indicating whether resync is required for this disk.
   */
  resyncRequired?: string;

  /**
   * The resync progress percentage.
   */
  resyncProgressPercentage?: int32;

  /**
   * The resync duration in seconds.
   */
  resyncDurationInSeconds?: int64;

  /**
   * The disk capacity in bytes.
   */
  diskCapacityInBytes?: int64;

  /**
   * The disk file system capacity in bytes.
   */
  fileSystemCapacityInBytes?: int64;

  /**
   * The source data transit in MB.
   */
  sourceDataInMegaBytes?: float64;

  /**
   * The PS data transit in MB.
   */
  psDataInMegaBytes?: float64;

  /**
   * The target data transit in MB.
   */
  targetDataInMegaBytes?: float64;

  /**
   * A value indicating whether disk is resized.
   */
  diskResized?: string;

  /**
   * The last RPO calculated time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The resync processed bytes.
   */
  resyncProcessedBytes?: int64;

  /**
   * The resync total transferred bytes.
   */
  resyncTotalTransferredBytes?: int64;

  /**
   * The resync last 15 minutes transferred bytes.
   */
  resyncLast15MinutesTransferredBytes?: int64;

  /**
   * The last data transfer time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resyncLastDataTransferTimeUTC?: utcDateTime;

  /**
   * The resync start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resyncStartTime?: utcDateTime;

  /**
   * The Progress Health.
   */
  progressHealth?: string;

  /**
   * The Progress Status.
   */
  progressStatus?: string;

  /**
   * The seconds to take for switch provider.
   */
  secondsToTakeSwitchProvider?: int64;
}

/**
 * InMage Azure V2 provider specific recovery point details.
 */
model InMageAzureV2RecoveryPointDetails
  extends ProviderSpecificRecoveryPointDetails {
  /**
   * A value indicating whether the recovery point is multi VM consistent.
   */
  isMultiVmSyncPoint?: string;

  /**
   * Gets the provider type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * InMageAzureV2 provider specific settings.
 */
model InMageAzureV2ReplicationDetails
  extends ReplicationProviderSpecificSettings {
  /**
   * The infrastructure VM Id.
   */
  infrastructureVmId?: string;

  /**
   * The vCenter infrastructure Id.
   */
  vCenterInfrastructureId?: string;

  /**
   * The protection stage.
   */
  protectionStage?: string;

  /**
   * The virtual machine Id.
   */
  vmId?: string;

  /**
   * The protection state for the vm.
   */
  vmProtectionState?: string;

  /**
   * The protection state description for the vm.
   */
  vmProtectionStateDescription?: string;

  /**
   * The resync progress percentage.
   */
  resyncProgressPercentage?: int32;

  /**
   * The RPO in seconds.
   */
  rpoInSeconds?: int64;

  /**
   * The compressed data change rate in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  compressedDataRateInMB?: float64;

  /**
   * The uncompressed data change rate in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  uncompressedDataRateInMB?: float64;

  /**
   * The source IP address.
   */
  ipAddress?: string;

  /**
   * The agent version.
   */
  agentVersion?: string;

  /**
   * Agent expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentExpiryDate?: utcDateTime;

  /**
   * A value indicating whether installed agent needs to be updated.
   */
  isAgentUpdateRequired?: string;

  /**
   * A value indicating whether the source server requires a restart after update.
   */
  isRebootAfterUpdateRequired?: string;

  /**
   * The last heartbeat received from the source server.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * The process server Id.
   */
  processServerId?: string;

  /**
   * The process server name.
   */
  processServerName?: string;

  /**
   * The multi vm group Id.
   */
  multiVmGroupId?: string;

  /**
   * The multi vm group name.
   */
  multiVmGroupName?: string;

  /**
   * A value indicating whether multi vm sync is enabled or disabled.
   */
  multiVmSyncStatus?: string;

  /**
   * The list of protected disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedDisks?: InMageAzureV2ProtectedDiskDetails[];

  /**
   * A value indicating whether any disk is resized for this VM.
   */
  diskResized?: string;

  /**
   * The master target Id.
   */
  masterTargetId?: string;

  /**
   * The CPU count of the VM on the primary side.
   */
  sourceVmCpuCount?: int32;

  /**
   * The RAM size of the VM on the primary side.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceVmRamSizeInMB?: int32;

  /**
   * The type of the OS on the VM.
   */
  osType?: string;

  /**
   * The OS disk VHD name.
   */
  vhdName?: string;

  /**
   * The id of the disk containing the OS.
   */
  osDiskId?: string;

  /**
   * Azure VM Disk details.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureVMDiskDetails?: AzureVmDiskDetails[];

  /**
   * Recovery Azure given name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryAzureVMName?: string;

  /**
   * The Recovery Azure VM size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryAzureVMSize?: string;

  /**
   * The recovery Azure storage account.
   */
  recoveryAzureStorageAccount?: string;

  /**
   * The ARM id of the log storage account used for replication. This will be set to null if no log storage account was provided during enable protection.
   */
  recoveryAzureLogStorageAccountId?: string;

  /**
   * The PE Network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMNicDetails[];

  /**
   * The selected recovery azure network Id.
   */
  selectedRecoveryAzureNetworkId?: string;

  /**
   * The test failover virtual network.
   */
  selectedTfoAzureNetworkId?: string;

  /**
   * The selected source nic Id which will be used as the primary nic during failover.
   */
  selectedSourceNicId?: string;

  /**
   * A value indicating the discovery type of the machine. Value can be vCenter or physical.
   */
  discoveryType?: string;

  /**
   * The selected option to enable RDP\SSH on target vm after failover. String value of SrsDataContract.EnableRDPOnTargetOption enum.
   */
  enableRdpOnTargetOption?: string;

  /**
   * The datastores of the on-premise machine. Value can be list of strings that contain datastore names.
   */
  datastores?: string[];

  /**
   * The ARM Id of the target Azure VM. This value will be null until the VM is failed over. Only after failure it will be populated with the ARM Id of the Azure VM.
   */
  targetVmId?: string;

  /**
   * The target resource group Id.
   */
  recoveryAzureResourceGroupId?: string;

  /**
   * The recovery availability set Id.
   */
  recoveryAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target proximity placement group Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * A value indicating whether managed disks should be used during failover.
   */
  useManagedDisks?: string;

  /**
   * License Type of the VM to be used.
   */
  licenseType?: string;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: string;

  /**
   * The validation errors of the on-premise machine Value can be list of validation errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationErrors?: HealthError[];

  /**
   * The last RPO calculated time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The last update time received from on-prem components.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateReceivedTime?: utcDateTime;

  /**
   * The replica id of the protected item.
   */
  replicaId?: string;

  /**
   * The OS Version of the protected item.
   */
  osVersion?: string;

  /**
   * The list of protected managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedManagedDisks?: InMageAzureV2ManagedDiskDetails[];

  /**
   * The last recovery point received time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  /**
   * The firmware type of this protected item.
   */
  firmwareType?: string;

  /**
   * The target generation for this protected item.
   */
  azureVmGeneration?: string;

  /**
   * A value indicating whether additional IR stats are available or not.
   */
  isAdditionalStatsAvailable?: boolean;

  /**
   * The total transferred data in bytes.
   */
  totalDataTransferred?: int64;

  /**
   * The progress health.
   */
  totalProgressHealth?: string;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The tags for the seed managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  seedManagedDiskTags?: Record<string>;

  /**
   * The tags for the target managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetManagedDiskTags?: Record<string>;

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The switch provider blocking error information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  switchProviderBlockingErrorDetails?: InMageAzureV2SwitchProviderBlockingErrorDetails[];

  /**
   * The switch provider blocking error information.
   */
  switchProviderDetails?: InMageAzureV2SwitchProviderDetails;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportedOSVersions?: string[];

  /**
   * A value indicating all available inplace OS Upgrade configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  allAvailableOSUpgradeConfigurations?: OSUpgradeSupportedVersions[];

  /**
   * The name of the OS on the VM.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * Gets the Instance type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * InMageAzureV2 switch provider blocking error details.
 */
model InMageAzureV2SwitchProviderBlockingErrorDetails {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * The possible causes.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * The recommended action.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * The error message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorMessageParameters?: Record<string>;

  /**
   * The error tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorTags?: Record<string>;
}

/**
 * InMageAzureV2 switch provider details.
 */
model InMageAzureV2SwitchProviderDetails {
  /**
   * The target vault Id.
   */
  @visibility(Lifecycle.Read)
  targetVaultId?: string;

  /**
   * The target resource Id.
   */
  @visibility(Lifecycle.Read)
  targetResourceId?: string;

  /**
   * The target fabric Id.
   */
  @visibility(Lifecycle.Read)
  targetFabricId?: string;

  /**
   * The target appliance Id.
   */
  @visibility(Lifecycle.Read)
  targetApplianceId?: string;
}

/**
 * InMageAzureV2 specific provider input.
 */
model InMageAzureV2ReprotectInput
  extends ReverseReplicationProviderSpecificInput {
  /**
   * The Master target Id.
   */
  masterTargetId?: string;

  /**
   * The Process Server Id.
   */
  processServerId?: string;

  /**
   * The storage account id.
   */
  storageAccountId?: string;

  /**
   * The CS account Id.
   */
  runAsAccountId?: string;

  /**
   * The Policy Id.
   */
  policyId?: string;

  /**
   * The storage account to be used for logging during replication.
   */
  logStorageAccountId?: string;

  /**
   * The disks to include list.
   */
  disksToInclude?: string[];

  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * Provider specific input for InMageAzureV2 switch provider.
 */
model InMageAzureV2SwitchProviderProviderInput
  extends SwitchProviderProviderSpecificInput {
  /**
   * The target vault Id.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVaultID: string;

  /**
   * The target fabric Id.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetFabricID: string;

  /**
   * The target appliance Id.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetApplianceID: string;

  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * InMageAzureV2 provider specific input for test failover.
 */
model InMageAzureV2TestFailoverInput extends TestFailoverProviderSpecificInput {
  /**
   * The recovery point id to be passed to test failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  osUpgradeVersion?: string;

  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * InMageAzureV2 provider specific input for unplanned failover.
 */
model InMageAzureV2UnplannedFailoverInput
  extends UnplannedFailoverProviderSpecificInput {
  /**
   * The recovery point id to be passed to failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  osUpgradeVersion?: string;

  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * InMage Azure V2 input to update replication protected item.
 */
model InMageAzureV2UpdateReplicationProtectedItemInput
  extends UpdateReplicationProtectedItemProviderInput {
  /**
   * The recovery Azure resource group Id for classic deployment.
   */
  recoveryAzureV1ResourceGroupId?: string;

  /**
   * The recovery Azure resource group Id for resource manager deployment.
   */
  recoveryAzureV2ResourceGroupId?: string;

  /**
   * A value indicating whether managed disks should be used during failover.
   */
  useManagedDisks?: string;

  /**
   * The target proximity placement group Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The tags for the target managed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetManagedDiskTags?: Record<string>;

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * The list of disk update properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: UpdateDiskInput[];

  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * Base class for the policies of providers using InMage replication.
 */
model InMageBasePolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * The recovery point threshold in minutes.
   */
  recoveryPointThresholdInMinutes?: int32;

  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistory?: int32;

  /**
   * The app consistent snapshot frequency in minutes.
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled.
   */
  multiVmSyncStatus?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageBasePolicyDetails";
}

/**
 * InMage disable protection provider specific input.
 */
model InMageDisableProtectionProviderSpecificInput
  extends DisableProtectionProviderSpecificInput {
  /**
   * A value indicating whether the replica VM should be destroyed or retained. Values from Delete and Retain.
   */
  replicaVmDeletionStatus?: string;

  /**
   * The class type.
   */
  instanceType: "InMage";
}

/**
 * VMware/Physical specific Disk Details.
 */
model InMageDiskDetails {
  /**
   * The disk Id.
   */
  diskId?: string;

  /**
   * The disk name.
   */
  diskName?: string;

  /**
   * The disk size in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInMB?: string;

  /**
   * Whether disk is system disk or data disk.
   */
  diskType?: string;

  /**
   * Whether disk is dynamic disk or basic disk.
   */
  diskConfiguration?: string;

  /**
   * Volumes of the disk.
   */
  volumeList?: DiskVolumeDetails[];
}

/**
 * DiskExclusionInput when doing enable protection of virtual machine in InMage provider.
 */
model InMageDiskExclusionInput {
  /**
   * The volume label based option for disk exclusion.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  volumeOptions?: InMageVolumeExclusionOptions[];

  /**
   * The guest disk signature based option for disk exclusion.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSignatureOptions?: InMageDiskSignatureExclusionOptions[];
}

/**
 * Guest disk signature based disk exclusion option when doing enable protection of virtual machine in InMage provider.
 */
model InMageVolumeExclusionOptions {
  /**
   * The volume label. The disk having any volume with this label will be excluded from replication.
   */
  volumeLabel?: string;

  /**
   * The value indicating whether to exclude multi volume disk or not. If a disk has multiple volumes and one of the volume has label matching with VolumeLabel this disk will be excluded from replication if OnlyExcludeIfSingleVolume is false.
   */
  onlyExcludeIfSingleVolume?: string;
}

/**
 * Guest disk signature based disk exclusion option when doing enable protection of virtual machine in InMage provider.
 */
model InMageDiskSignatureExclusionOptions {
  /**
   * The guest signature of disk to be excluded from replication.
   */
  diskSignature?: string;
}

/**
 * VMware Azure specific enable protection input.
 */
model InMageEnableProtectionInput
  extends EnableProtectionProviderSpecificInput {
  /**
   * The VM Name.
   */
  vmFriendlyName?: string;

  /**
   * The Master Target Id.
   */
  masterTargetId: string;

  /**
   * The Process Server Id.
   */
  processServerId: string;

  /**
   * The retention drive to use on the MT.
   */
  retentionDrive: string;

  /**
   * The CS account Id.
   */
  runAsAccountId?: string;

  /**
   * The multi VM group Id.
   */
  multiVmGroupId: string;

  /**
   * The multi VM group name.
   */
  multiVmGroupName: string;

  /**
   * The target datastore name.
   */
  datastoreName?: string;

  /**
   * The enable disk exclusion input.
   */
  diskExclusionInput?: InMageDiskExclusionInput;

  /**
   * The disks to include list.
   */
  disksToInclude?: string[];

  /**
   * The class type.
   */
  instanceType: "InMage";
}

/**
 * InMageFabric switch provider blocking error details.
 */
model InMageFabricSwitchProviderBlockingErrorDetails {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * The possible causes.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * The recommended action.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * The error message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorMessageParameters?: Record<string>;

  /**
   * The error tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorTags?: Record<string>;
}

/**
 * InMage specific protection profile details.
 */
model InMagePolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * The recovery point threshold in minutes.
   */
  recoveryPointThresholdInMinutes?: int32;

  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistory?: int32;

  /**
   * The app consistent snapshot frequency in minutes.
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled.
   */
  multiVmSyncStatus?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMage";
}

/**
 * VMWare Azure specific protection profile Input.
 */
model InMagePolicyInput extends PolicyProviderSpecificInput {
  /**
   * The recovery point threshold in minutes.
   */
  recoveryPointThresholdInMinutes?: int32;

  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistory?: int32;

  /**
   * The app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled. Value should be 'Enabled' or 'Disabled'.
   */
  multiVmSyncStatus: SetMultiVmSyncStatus;

  /**
   * The class type.
   */
  instanceType: "InMage";
}

/**
 * InMage protected disk details.
 */
model InMageProtectedDiskDetails {
  /**
   * The disk id.
   */
  diskId?: string;

  /**
   * The disk name.
   */
  diskName?: string;

  /**
   * The protection stage.
   */
  protectionStage?: string;

  /**
   * The health error code for the disk.
   */
  healthErrorCode?: string;

  /**
   * The RPO in seconds.
   */
  rpoInSeconds?: int64;

  /**
   * A value indicating whether resync is required for this disk.
   */
  resyncRequired?: string;

  /**
   * The resync progress percentage.
   */
  resyncProgressPercentage?: int32;

  /**
   * The resync duration in seconds.
   */
  resyncDurationInSeconds?: int64;

  /**
   * The disk capacity in bytes.
   */
  diskCapacityInBytes?: int64;

  /**
   * The file system capacity in bytes.
   */
  fileSystemCapacityInBytes?: int64;

  /**
   * The source data transit in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceDataInMB?: float64;

  /**
   * The PS data transit in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  psDataInMB?: float64;

  /**
   * The target data transit in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetDataInMB?: float64;

  /**
   * A value indicating whether disk is resized.
   */
  diskResized?: string;

  /**
   * The last RPO calculated time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The resync processed bytes.
   */
  resyncProcessedBytes?: int64;

  /**
   * The resync total transferred bytes.
   */
  resyncTotalTransferredBytes?: int64;

  /**
   * The resync last 15 minutes transferred bytes.
   */
  resyncLast15MinutesTransferredBytes?: int64;

  /**
   * The last data transfer time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resyncLastDataTransferTimeUTC?: utcDateTime;

  /**
   * The resync start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resyncStartTime?: utcDateTime;

  /**
   * The Progress Health.
   */
  progressHealth?: string;

  /**
   * The Progress Status.
   */
  progressStatus?: string;
}

/**
 * InMageRcm add disk(s) input.
 */
model InMageRcmAddDisksInput extends AddDisksProviderSpecificInput {
  /**
   * The list of disk details.
   */
  @identifiers(#["diskId"])
  disks: InMageRcmDiskInput[];

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm disk input.
 */
model InMageRcmDiskInput {
  /**
   * The disk Id.
   */
  diskId: string;

  /**
   * The log storage account ARM Id.
   */
  logStorageAccountId: string;

  /**
   * The disk type.
   */
  diskType: DiskAccountType;

  /**
   * The DiskEncryptionSet ARM Id.
   */
  diskEncryptionSetId?: string;

  /**
   * The logical sector size (in bytes), 512 by default.
   */
  sectorSizeInBytes?: int32;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * InMageRcm source agent reinstall blocking error details.
 */
model InMageRcmAgentReinstallBlockingErrorDetails {
  /**
   * error code.
   */
  errorCode?: string;

  /**
   * error message.
   */
  errorMessage?: string;

  /**
   * possible causes.
   */
  possibleCauses?: string;

  /**
   * recommended action.
   */
  recommendedAction?: string;

  /**
   * error message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorMessageParameters?: Record<string>;

  /**
   * error tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorTags?: Record<string>;
}

/**
 * InMageRcm source agent upgrade blocking error details.
 */
model InMageRcmAgentUpgradeBlockingErrorDetails {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * The possible causes.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * The recommended action.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * The error message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorMessageParameters?: Record<string>;

  /**
   * The error tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorTags?: Record<string>;
}

/**
 * InMageRcm appliance details.
 */
model InMageRcmApplianceDetails {
  /**
   * The appliance Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The appliance name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The fabric ARM Id.
   */
  @visibility(Lifecycle.Read)
  fabricArmId?: string;

  /**
   * The process server.
   */
  @visibility(Lifecycle.Read)
  processServer?: ProcessServerDetails;

  /**
   * The of RCM proxy.
   */
  @visibility(Lifecycle.Read)
  rcmProxy?: RcmProxyDetails;

  /**
   * The push installer.
   */
  @visibility(Lifecycle.Read)
  pushInstaller?: PushInstallerDetails;

  /**
   * The replication agent.
   */
  @visibility(Lifecycle.Read)
  replicationAgent?: ReplicationAgentDetails;

  /**
   * The reprotect agent.
   */
  @visibility(Lifecycle.Read)
  reprotectAgent?: ReprotectAgentDetails;

  /**
   * The Mars agent.
   */
  @visibility(Lifecycle.Read)
  marsAgent?: MarsAgentDetails;

  /**
   * The DRA.
   */
  @visibility(Lifecycle.Read)
  dra?: DraDetails;

  /**
   * The switch provider blocking error information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  switchProviderBlockingErrorDetails?: InMageRcmFabricSwitchProviderBlockingErrorDetails[];
}

/**
 * Process server details.
 */
model ProcessServerDetails {
  /**
   * The process server Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The process server name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The process server Bios Id.
   */
  @visibility(Lifecycle.Read)
  biosId?: string;

  /**
   * The fabric object Id.
   */
  @visibility(Lifecycle.Read)
  fabricObjectId?: string;

  /**
   * The process server Fqdn.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The list of IP addresses for communicating with the RCM component.
   */
  @visibility(Lifecycle.Read)
  ipAddresses?: string[];

  /**
   * The version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The last heartbeat received from the process server.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The total memory.
   */
  @visibility(Lifecycle.Read)
  totalMemoryInBytes?: int64;

  /**
   * The available memory.
   */
  @visibility(Lifecycle.Read)
  availableMemoryInBytes?: int64;

  /**
   * The used memory.
   */
  @visibility(Lifecycle.Read)
  usedMemoryInBytes?: int64;

  /**
   * The memory usage percentage.
   */
  @visibility(Lifecycle.Read)
  memoryUsagePercentage?: float64;

  /**
   * The total disk space.
   */
  @visibility(Lifecycle.Read)
  totalSpaceInBytes?: int64;

  /**
   * The available disk space.
   */
  @visibility(Lifecycle.Read)
  availableSpaceInBytes?: int64;

  /**
   * The used disk space.
   */
  @visibility(Lifecycle.Read)
  usedSpaceInBytes?: int64;

  /**
   * The free disk space percentage.
   */
  @visibility(Lifecycle.Read)
  freeSpacePercentage?: float64;

  /**
   * The uploading pending data in bytes.
   */
  @visibility(Lifecycle.Read)
  throughputUploadPendingDataInBytes?: int64;

  /**
   * The throughput in bytes.
   */
  @visibility(Lifecycle.Read)
  throughputInBytes?: int64;

  /**
   * The processor usage percentage.
   */
  @visibility(Lifecycle.Read)
  processorUsagePercentage?: float64;

  /**
   * The throughput status.
   */
  @visibility(Lifecycle.Read)
  throughputStatus?: RcmComponentStatus;

  /**
   * The system load.
   */
  @visibility(Lifecycle.Read)
  systemLoad?: int64;

  /**
   * The system load status.
   */
  @visibility(Lifecycle.Read)
  systemLoadStatus?: RcmComponentStatus;

  /**
   * The disk usage status.
   */
  @visibility(Lifecycle.Read)
  diskUsageStatus?: RcmComponentStatus;

  /**
   * The memory usage status.
   */
  @visibility(Lifecycle.Read)
  memoryUsageStatus?: RcmComponentStatus;

  /**
   * The processor usage status.
   */
  @visibility(Lifecycle.Read)
  processorUsageStatus?: RcmComponentStatus;

  /**
   * The health of the process server.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  healthErrors?: HealthError[];

  /**
   * The protected item count.
   */
  @visibility(Lifecycle.Read)
  protectedItemCount?: int32;

  /**
   * The historic health of the process server based on the health in last 24 hours.
   */
  @visibility(Lifecycle.Read)
  historicHealth?: ProtectionHealth;
}

/**
 * RCM proxy details.
 */
model RcmProxyDetails {
  /**
   * The RCM proxy Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The RCM proxy name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The RCM proxy Bios Id.
   */
  @visibility(Lifecycle.Read)
  biosId?: string;

  /**
   * The fabric object Id.
   */
  @visibility(Lifecycle.Read)
  fabricObjectId?: string;

  /**
   * The RCM proxy Fqdn.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The client authentication type.
   */
  @visibility(Lifecycle.Read)
  clientAuthenticationType?: string;

  /**
   * The version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The last heartbeat received from the RCM proxy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The health of the RCM proxy.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  healthErrors?: HealthError[];
}

/**
 * Push installer details.
 */
model PushInstallerDetails {
  /**
   * The push installer Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The push installer name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The push installer Bios Id.
   */
  @visibility(Lifecycle.Read)
  biosId?: string;

  /**
   * The fabric object Id.
   */
  @visibility(Lifecycle.Read)
  fabricObjectId?: string;

  /**
   * The push installer Fqdn.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The last heartbeat received from the push installer.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The health of the push installer.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  healthErrors?: HealthError[];
}

/**
 * Replication agent details.
 */
model ReplicationAgentDetails {
  /**
   * The replication agent Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The replication agent name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The replication agent Bios Id.
   */
  @visibility(Lifecycle.Read)
  biosId?: string;

  /**
   * The fabric object Id.
   */
  @visibility(Lifecycle.Read)
  fabricObjectId?: string;

  /**
   * The replication agent Fqdn.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The last heartbeat received from the replication agent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The health of the replication agent.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  healthErrors?: HealthError[];
}

/**
 * Reprotect agent details.
 */
model ReprotectAgentDetails {
  /**
   * The reprotect agent Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The reprotect agent name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The reprotect agent Bios Id.
   */
  @visibility(Lifecycle.Read)
  biosId?: string;

  /**
   * The fabric object Id.
   */
  @visibility(Lifecycle.Read)
  fabricObjectId?: string;

  /**
   * The reprotect agent Fqdn.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The last heartbeat received from the reprotect agent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The health of the reprotect agent.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The health errors.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["errorCode"])
  healthErrors?: HealthError[];

  /**
   * The protected item count.
   */
  @visibility(Lifecycle.Read)
  protectedItemCount?: int32;

  /**
   * The list of accessible datastores fetched from discovery.
   */
  @visibility(Lifecycle.Read)
  accessibleDatastores?: string[];

  /**
   * The Vcenter Id.
   */
  @visibility(Lifecycle.Read)
  vcenterId?: string;

  /**
   * The last time when SDS information discovered in SRS.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDiscoveryInUtc?: utcDateTime;
}

/**
 * Mars agent details.
 */
model MarsAgentDetails {
  /**
   * The Mars agent Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The Mars agent name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The Mars agent Bios Id.
   */
  @visibility(Lifecycle.Read)
  biosId?: string;

  /**
   * The fabric object Id.
   */
  @visibility(Lifecycle.Read)
  fabricObjectId?: string;

  /**
   * The Mars agent Fqdn.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The last heartbeat received from the Mars agent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The health of the Mars agent.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  healthErrors?: HealthError[];
}

/**
 * InMageRcmFabric switch provider blocking error details.
 */
model InMageRcmFabricSwitchProviderBlockingErrorDetails {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * The possible causes.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * The recommended action.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * The error message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorMessageParameters?: Record<string>;

  /**
   * The error tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorTags?: Record<string>;
}

/**
 * InMageRcm appliance specific details.
 */
model InMageRcmApplianceSpecificDetails extends ApplianceSpecificDetails {
  /**
   * The list of appliances.
   */
  @visibility(Lifecycle.Read)
  appliances?: InMageRcmApplianceDetails[];

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageRcm";
}

/**
 * ApplyRecoveryPoint input specific to InMageRcm provider.
 */
model InMageRcmApplyRecoveryPointInput
  extends ApplyRecoveryPointProviderSpecificInput {
  /**
   * The recovery point Id.
   */
  recoveryPointId: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm discovered protected VM details.
 */
model InMageRcmDiscoveredProtectedVmDetails {
  /**
   * The VCenter Id.
   */
  @visibility(Lifecycle.Read)
  vCenterId?: string;

  /**
   * The VCenter fqdn.
   */
  @visibility(Lifecycle.Read)
  vCenterFqdn?: string;

  /**
   * The list of datastores.
   */
  @visibility(Lifecycle.Read)
  datastores?: string[];

  /**
   * The list of IP addresses.
   */
  @visibility(Lifecycle.Read)
  ipAddresses?: string[];

  /**
   * The VMware tools status.
   */
  @visibility(Lifecycle.Read)
  vmwareToolsStatus?: string;

  /**
   * The VM power status.
   */
  @visibility(Lifecycle.Read)
  powerStatus?: string;

  /**
   * The VM fqdn.
   */
  @visibility(Lifecycle.Read)
  vmFqdn?: string;

  /**
   * The VM's OS name.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * The SDS created timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimestamp?: utcDateTime;

  /**
   * The SDS updated timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTimestamp?: utcDateTime;

  /**
   * A value indicating whether the VM is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * The last time when SDS information discovered in SRS.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDiscoveryTimeInUtc?: utcDateTime;
}

/**
 * InMageRcm disk input.
 */
model InMageRcmDisksDefaultInput {
  /**
   * The log storage account ARM Id.
   */
  logStorageAccountId: string;

  /**
   * The disk type.
   */
  diskType: DiskAccountType;

  /**
   * The DiskEncryptionSet ARM Id.
   */
  diskEncryptionSetId?: string;

  /**
   * The logical sector size (in bytes), 512 by default.
   */
  sectorSizeInBytes?: int32;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * InMageRcm specific enable protection input.
 */
model InMageRcmEnableProtectionInput
  extends EnableProtectionProviderSpecificInput {
  /**
   * The ARM Id of discovered machine.
   */
  fabricDiscoveryMachineId: string;

  /**
   * The disks to include list.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disksToInclude?: InMageRcmDiskInput[];

  /**
   * The default disk input.
   */
  disksDefault?: InMageRcmDisksDefaultInput;

  /**
   * The target resource group ARM Id.
   */
  targetResourceGroupId: string;

  /**
   * The selected target network ARM Id.
   */
  targetNetworkId?: string;

  /**
   * The selected test network ARM Id.
   */
  testNetworkId?: string;

  /**
   * The selected target subnet name.
   */
  targetSubnetName?: string;

  /**
   * The selected test subnet name.
   */
  testSubnetName?: string;

  /**
   * The target VM name.
   */
  targetVmName?: string;

  /**
   * The target VM size.
   */
  targetVmSize?: string;

  /**
   * The license type.
   */
  licenseType?: LicenseType;

  /**
   * The target availability set ARM Id.
   */
  targetAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target proximity placement group Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * The target boot diagnostics storage account ARM Id.
   */
  targetBootDiagnosticsStorageAccountId?: string;

  /**
   * The run-as account Id.
   */
  runAsAccountId?: string;

  /**
   * The process server Id.
   */
  processServerId: string;

  /**
   * The multi VM group name.
   */
  multiVmGroupName?: string;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * The target VM tags.
   */
  @identifiers(#["tagName"])
  targetVmTags?: UserCreatedResourceTag[];

  /**
   * The tags for the seed managed disks.
   */
  @identifiers(#["tagName"])
  seedManagedDiskTags?: UserCreatedResourceTag[];

  /**
   * The tags for the target managed disks.
   */
  @identifiers(#["tagName"])
  targetManagedDiskTags?: UserCreatedResourceTag[];

  /**
   * The tags for the target NICs.
   */
  @identifiers(#["tagName"])
  targetNicTags?: UserCreatedResourceTag[];

  /**
   * The OS name selected by user.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userSelectedOSName?: string;

  /**
   * The target VM security profile.
   */
  targetVmSecurityProfile?: SecurityProfileProperties;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * Resource tag input.
 */
model UserCreatedResourceTag {
  /**
   * The tag name. Please read for more information: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources#limitations
   */
  @maxLength(512)
  tagName?: string;

  /**
   * The tag value. Please read her for more information: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources#limitations
   */
  @maxLength(256)
  tagValue?: string;
}

/**
 * Event details for InMageRcm provider.
 */
model InMageRcmEventDetails extends EventProviderSpecificDetails {
  /**
   * The protected item name.
   */
  @visibility(Lifecycle.Read)
  protectedItemName?: string;

  /**
   * The protected item name.
   */
  @visibility(Lifecycle.Read)
  vmName?: string;

  /**
   * The latest agent version.
   */
  @visibility(Lifecycle.Read)
  latestAgentVersion?: string;

  /**
   * The job Id.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The fabric name.
   */
  @visibility(Lifecycle.Read)
  fabricName?: string;

  /**
   * The appliance name.
   */
  @visibility(Lifecycle.Read)
  applianceName?: string;

  /**
   * The server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * The component display name.
   */
  @visibility(Lifecycle.Read)
  componentDisplayName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm fabric provider specific settings.
 */
model InMageRcmFabricCreationInput extends FabricSpecificCreationInput {
  /**
   * The ARM Id of the VMware site.
   */
  vmwareSiteId: string;

  /**
   * The ARM Id of the physical site.
   */
  physicalSiteId: string;

  /**
   * The identity provider input for source agent authentication.
   */
  sourceAgentIdentity: IdentityProviderInput;

  /**
   * Gets the class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm fabric specific details.
 */
model InMageRcmFabricSpecificDetails extends FabricSpecificDetails {
  /**
   * The ARM Id of the VMware site.
   */
  @visibility(Lifecycle.Read)
  vmwareSiteId?: string;

  /**
   * The ARM Id of the physical site.
   */
  @visibility(Lifecycle.Read)
  physicalSiteId?: string;

  /**
   * The service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * The service resource Id.
   */
  @visibility(Lifecycle.Read)
  serviceResourceId?: string;

  /**
   * The service container Id.
   */
  @visibility(Lifecycle.Read)
  serviceContainerId?: string;

  /**
   * The data plane Uri.
   */
  @visibility(Lifecycle.Read)
  dataPlaneUri?: string;

  /**
   * The control plane Uri.
   */
  @visibility(Lifecycle.Read)
  controlPlaneUri?: string;

  /**
   * The source agent identity details.
   */
  sourceAgentIdentityDetails?: IdentityProviderDetails;

  /**
   * The list of process servers.
   */
  @visibility(Lifecycle.Read)
  processServers?: ProcessServerDetails[];

  /**
   * The list of RCM proxies.
   */
  @visibility(Lifecycle.Read)
  rcmProxies?: RcmProxyDetails[];

  /**
   * The list of push installers.
   */
  @visibility(Lifecycle.Read)
  pushInstallers?: PushInstallerDetails[];

  /**
   * The list of replication agents.
   */
  @visibility(Lifecycle.Read)
  replicationAgents?: ReplicationAgentDetails[];

  /**
   * The list of reprotect agents.
   */
  @visibility(Lifecycle.Read)
  reprotectAgents?: ReprotectAgentDetails[];

  /**
   * The list of Mars agents.
   */
  @visibility(Lifecycle.Read)
  marsAgents?: MarsAgentDetails[];

  /**
   * The list of DRAs.
   */
  @visibility(Lifecycle.Read)
  dras?: DraDetails[];

  /**
   * The list of agent details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  agentDetails?: AgentDetails[];

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcmFailback discovered VM details.
 */
model InMageRcmFailbackDiscoveredProtectedVmDetails {
  /**
   * The VCenter Id.
   */
  @visibility(Lifecycle.Read)
  vCenterId?: string;

  /**
   * The VCenter fqdn.
   */
  @visibility(Lifecycle.Read)
  vCenterFqdn?: string;

  /**
   * The list of datastores.
   */
  @visibility(Lifecycle.Read)
  datastores?: string[];

  /**
   * The list of IP addresses.
   */
  @visibility(Lifecycle.Read)
  ipAddresses?: string[];

  /**
   * The VMware tools status.
   */
  @visibility(Lifecycle.Read)
  vmwareToolsStatus?: string;

  /**
   * The VM power status.
   */
  @visibility(Lifecycle.Read)
  powerStatus?: string;

  /**
   * The VM fqdn.
   */
  @visibility(Lifecycle.Read)
  vmFqdn?: string;

  /**
   * The VM's OS name.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * The SDS created timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimestamp?: utcDateTime;

  /**
   * The SDS updated timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTimestamp?: utcDateTime;

  /**
   * A value indicating whether the VM is deleted.
   */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /**
   * The last time when SDS information discovered in SRS.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDiscoveryTimeInUtc?: utcDateTime;
}

/**
 * Event details for InMageRcmFailback provider.
 */
model InMageRcmFailbackEventDetails extends EventProviderSpecificDetails {
  /**
   * The protected item name.
   */
  @visibility(Lifecycle.Read)
  protectedItemName?: string;

  /**
   * The protected item name.
   */
  @visibility(Lifecycle.Read)
  vmName?: string;

  /**
   * The appliance name.
   */
  @visibility(Lifecycle.Read)
  applianceName?: string;

  /**
   * The server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * The component display name.
   */
  @visibility(Lifecycle.Read)
  componentDisplayName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageRcmFailback";
}

/**
 * InMageRcmFailback mobility agent details.
 */
model InMageRcmFailbackMobilityAgentDetails {
  /**
   * The agent version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The latest agent version available.
   */
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  /**
   * The driver version.
   */
  @visibility(Lifecycle.Read)
  driverVersion?: string;

  /**
   * The latest upgradeable version available without reboot.
   */
  @visibility(Lifecycle.Read)
  latestUpgradableVersionWithoutReboot?: string;

  /**
   * The agent version expiry date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentVersionExpiryDate?: utcDateTime;

  /**
   * The driver version expiry date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  driverVersionExpiryDate?: utcDateTime;

  /**
   * The time of the last heartbeat received from the agent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The whether update is possible or not.
   */
  @visibility(Lifecycle.Read)
  reasonsBlockingUpgrade?: AgentUpgradeBlockedReason[];

  /**
   * A value indicating whether agent is upgradeable or not.
   */
  @visibility(Lifecycle.Read)
  isUpgradeable?: string;
}

/**
 * InMageRcmFailback NIC details.
 */
model InMageRcmFailbackNicDetails {
  /**
   * The mac address.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The network name.
   */
  @visibility(Lifecycle.Read)
  networkName?: string;

  /**
   * The adapter type.
   */
  @visibility(Lifecycle.Read)
  adapterType?: string;

  /**
   * The IP address.
   */
  @visibility(Lifecycle.Read)
  sourceIpAddress?: string;
}

/**
 * Provider specific input for InMageRcmFailback failover.
 */
model InMageRcmFailbackPlannedFailoverProviderInput
  extends PlannedFailoverProviderSpecificFailoverInput {
  /**
   * The recovery point type.
   */
  recoveryPointType: InMageRcmFailbackRecoveryPointType;

  /**
   * The class type.
   */
  instanceType: "InMageRcmFailback";
}

/**
 * InMageRcmFailback policy creation input.
 */
model InMageRcmFailbackPolicyCreationInput extends PolicyProviderSpecificInput {
  /**
   * The crash consistent snapshot frequency (in minutes).
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * The app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * The class type.
   */
  instanceType: "InMageRcmFailback";
}

/**
 * InMageRcm failback specific policy details.
 */
model InMageRcmFailbackPolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * The app consistent snapshot frequency in minutes.
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * The crash consistent snapshot frequency in minutes.
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageRcmFailback";
}

/**
 * InMageRcmFailback protected disk details.
 */
model InMageRcmFailbackProtectedDiskDetails {
  /**
   * The disk Id (reported by source agent).
   */
  @visibility(Lifecycle.Read)
  diskId?: string;

  /**
   * The disk name.
   */
  @visibility(Lifecycle.Read)
  diskName?: string;

  /**
   * A value indicating whether the disk is the OS disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  isOSDisk?: string;

  /**
   * The disk capacity in bytes.
   */
  @visibility(Lifecycle.Read)
  capacityInBytes?: int64;

  /**
   * The disk Uuid (reported by vCenter).
   */
  @visibility(Lifecycle.Read)
  diskUuid?: string;

  /**
   * The data pending in log data store in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  dataPendingInLogDataStoreInMB?: float64;

  /**
   * The data pending at source agent in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  dataPendingAtSourceAgentInMB?: float64;

  /**
   * A value indicating whether initial replication is complete or not.
   */
  @visibility(Lifecycle.Read)
  isInitialReplicationComplete?: string;

  /**
   * The initial replication details.
   */
  irDetails?: InMageRcmFailbackSyncDetails;

  /**
   * The resync details.
   */
  resyncDetails?: InMageRcmFailbackSyncDetails;

  /**
   * The last sync time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTime?: utcDateTime;
}

/**
 * InMageRcmFailback disk level sync details.
 */
model InMageRcmFailbackSyncDetails {
  /**
   * The progress health.
   */
  @visibility(Lifecycle.Read)
  progressHealth?: DiskReplicationProgressHealth;

  /**
   * The transferred bytes from source VM to azure for the disk.
   */
  @visibility(Lifecycle.Read)
  transferredBytes?: int64;

  /**
   * The bytes transferred in last 15 minutes from source VM to target.
   */
  @visibility(Lifecycle.Read)
  last15MinutesTransferredBytes?: int64;

  /**
   * The time of the last data transfer from source VM to target.
   */
  @visibility(Lifecycle.Read)
  lastDataTransferTimeUtc?: string;

  /**
   * The total processed bytes. This includes bytes that are transferred from source VM to target and matched bytes.
   */
  @visibility(Lifecycle.Read)
  processedBytes?: int64;

  /**
   * The start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The last refresh time.
   */
  @visibility(Lifecycle.Read)
  lastRefreshTime?: string;

  /**
   * Progress in percentage. Progress percentage is calculated based on processed bytes.
   */
  @visibility(Lifecycle.Read)
  progressPercentage?: int32;
}

/**
 * InMageRcmFailback provider specific details.
 */
model InMageRcmFailbackReplicationDetails
  extends ReplicationProviderSpecificSettings {
  /**
   * The virtual machine internal identifier.
   */
  @visibility(Lifecycle.Read)
  internalIdentifier?: string;

  /**
   * The ARM Id of the azure VM.
   */
  @visibility(Lifecycle.Read)
  azureVirtualMachineId?: string;

  /**
   * The multi VM group name.
   */
  @visibility(Lifecycle.Read)
  multiVmGroupName?: string;

  /**
   * The reprotect agent Id.
   */
  @visibility(Lifecycle.Read)
  reprotectAgentId?: string;

  /**
   * The reprotect agent name.
   */
  @visibility(Lifecycle.Read)
  reprotectAgentName?: string;

  /**
   * The type of the OS on the VM.
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * The log storage account ARM Id.
   */
  @visibility(Lifecycle.Read)
  logStorageAccountId?: string;

  /**
   * The target vCenter Id.
   */
  @visibility(Lifecycle.Read)
  targetvCenterId?: string;

  /**
   * The target datastore name.
   */
  @visibility(Lifecycle.Read)
  targetDataStoreName?: string;

  /**
   * The target VM name.
   */
  @visibility(Lifecycle.Read)
  targetVmName?: string;

  /**
   * The initial replication progress percentage.
   */
  @visibility(Lifecycle.Read)
  initialReplicationProgressPercentage?: int32;

  /**
   * The initial replication processed bytes. This includes sum of total bytes transferred and matched bytes on all selected disks in source VM.
   */
  @visibility(Lifecycle.Read)
  initialReplicationProcessedBytes?: int64;

  /**
   * The initial replication transferred bytes from source VM to target for all selected disks on source VM.
   */
  @visibility(Lifecycle.Read)
  initialReplicationTransferredBytes?: int64;

  /**
   * The initial replication progress health.
   */
  @visibility(Lifecycle.Read)
  initialReplicationProgressHealth?: VmReplicationProgressHealth;

  /**
   * The resync progress percentage.
   */
  @visibility(Lifecycle.Read)
  resyncProgressPercentage?: int32;

  /**
   * The resync processed bytes. This includes sum of total bytes transferred and matched bytes on all selected disks in source VM.
   */
  @visibility(Lifecycle.Read)
  resyncProcessedBytes?: int64;

  /**
   * The resync transferred bytes from source VM to target for all selected disks on source VM.
   */
  @visibility(Lifecycle.Read)
  resyncTransferredBytes?: int64;

  /**
   * The resync progress health.
   */
  @visibility(Lifecycle.Read)
  resyncProgressHealth?: VmReplicationProgressHealth;

  /**
   * A value indicating whether resync is required.
   */
  @visibility(Lifecycle.Read)
  resyncRequired?: string;

  /**
   * The resync state.
   */
  @visibility(Lifecycle.Read)
  resyncState?: ResyncState;

  /**
   * The list of protected disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedDisks?: InMageRcmFailbackProtectedDiskDetails[];

  /**
   * The mobility agent information.
   */
  mobilityAgentDetails?: InMageRcmFailbackMobilityAgentDetails;

  /**
   * The network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: InMageRcmFailbackNicDetails[];

  /**
   * The last planned failover start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastPlannedFailoverStartTime?: utcDateTime;

  /**
   * The last planned failover status.
   */
  @visibility(Lifecycle.Read)
  lastPlannedFailoverStatus?: PlannedFailoverStatus;

  /**
   * The discovered VM information.
   */
  discoveredVmDetails?: InMageRcmFailbackDiscoveredProtectedVmDetails;

  /**
   * The policy Id used by the forward replication.
   */
  @visibility(Lifecycle.Read)
  lastUsedPolicyId?: string;

  /**
   * The policy friendly name used by the forward replication.
   */
  @visibility(Lifecycle.Read)
  lastUsedPolicyFriendlyName?: string;

  /**
   * A value indicating whether agent registration was successful after failover.
   */
  @visibility(Lifecycle.Read)
  isAgentRegistrationSuccessfulAfterFailover?: boolean;

  /**
   * Gets the Instance type.
   */
  instanceType: "InMageRcmFailback";
}

/**
 * InMageRcmFailback specific provider input.
 */
model InMageRcmFailbackReprotectInput
  extends ReverseReplicationProviderSpecificInput {
  /**
   * The process server Id.
   */
  processServerId: string;

  /**
   * The run as account Id.
   */
  runAsAccountId?: string;

  /**
   * The Policy Id.
   */
  policyId: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcmFailback";
}

/**
 * InMageRcm source agent reinstall blocking error details.
 */
model InMageRcmLastAgentReinstallErrorDetails {
  /**
   * error code.
   */
  errorCode?: string;

  /**
   * error message.
   */
  errorMessage?: string;

  /**
   * possible causes.
   */
  possibleCauses?: string;

  /**
   * recommended action.
   */
  recommendedAction?: string;

  /**
   * error message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorMessageParameters?: Record<string>;

  /**
   * error tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorTags?: Record<string>;
}

/**
 * InMageRcm last source agent upgrade error details.
 */
model InMageRcmLastAgentUpgradeErrorDetails {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * The possible causes.
   */
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  /**
   * The recommended action.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * The error message parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorMessageParameters?: Record<string>;

  /**
   * The error tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorTags?: Record<string>;
}

/**
 * InMageRcm mobility agent details.
 */
model InMageRcmMobilityAgentDetails {
  /**
   * The agent version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The latest agent version available.
   */
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  /**
   * The latest agent version release date.
   */
  @visibility(Lifecycle.Read)
  latestAgentReleaseDate?: string;

  /**
   * The driver version.
   */
  @visibility(Lifecycle.Read)
  driverVersion?: string;

  /**
   * The latest upgradeable version available without reboot.
   */
  @visibility(Lifecycle.Read)
  latestUpgradableVersionWithoutReboot?: string;

  /**
   * The agent version expiry date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentVersionExpiryDate?: utcDateTime;

  /**
   * The driver version expiry date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  driverVersionExpiryDate?: utcDateTime;

  /**
   * The time of the last heartbeat received from the agent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeatUtc?: utcDateTime;

  /**
   * The whether update is possible or not.
   */
  @visibility(Lifecycle.Read)
  reasonsBlockingUpgrade?: AgentUpgradeBlockedReason[];

  /**
   * A value indicating whether agent is upgradeable or not.
   */
  @visibility(Lifecycle.Read)
  isUpgradeable?: string;

  /**
   * The agent auto reinstall state.
   */
  @visibility(Lifecycle.Read)
  agentReinstallState?: MobilityAgentReinstallType[];

  /**
   * The last agent reinstall type.
   */
  @visibility(Lifecycle.Read)
  lastAgentReinstallType?: string;

  /**
   * The agent reinstall job Id.
   */
  @visibility(Lifecycle.Read)
  agentReinstallJobId?: string;

  /**
   * The last agent reinstall type.
   */
  @visibility(Lifecycle.Read)
  agentReinstallAttemptToVersion?: string;

  /**
   * The OS family name.
   */
  osFamilyName?: string;

  /**
   * The distro name.
   */
  distroName?: string;

  /**
   * Distro name for which agent is installed.
   */
  distroNameForWhichAgentIsInstalled?: string;

  /**
   * A value indicating whether replication agent upgradeable.
   */
  isAgentUpgradeable?: boolean;

  /**
   * A value indicating whether replication agent reinstallation is required.
   */
  isAgentReinstallRequired?: boolean;

  /**
   * A value indicating whether replication agent reinstallation is required.
   */
  isLastReinstallSuccessful?: boolean;

  /**
   * whether reinstall is possible or not.
   */
  @visibility(Lifecycle.Read)
  reasonsBlockingReinstall?: AgentReinstallBlockedReason[];

  /**
   * whether reinstall is possible or not.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  reasonsBlockingReinstallDetails?: InMageRcmAgentReinstallBlockingErrorDetails[];
}

/**
 * InMageRcm NIC details.
 */
model InMageRcmNicDetails {
  /**
   * The NIC Id.
   */
  @visibility(Lifecycle.Read)
  nicId?: string;

  /**
   * A value indicating whether this is the primary NIC.
   */
  isPrimaryNic?: string;

  /**
   * A value indicating whether this NIC is selected for failover.
   */
  isSelectedForFailover?: string;

  /**
   * The source IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sourceIPAddress?: string;

  /**
   * The source IP address type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sourceIPAddressType?: EthernetAddressType;

  /**
   * Source network Id.
   */
  @visibility(Lifecycle.Read)
  sourceNetworkId?: string;

  /**
   * Source subnet name.
   */
  @visibility(Lifecycle.Read)
  sourceSubnetName?: string;

  /**
   * The target IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetIPAddress?: string;

  /**
   * The target IP address type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetIPAddressType?: EthernetAddressType;

  /**
   * Target subnet name.
   */
  targetSubnetName?: string;

  /**
   * Test subnet name.
   */
  testSubnetName?: string;

  /**
   * The test IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  testIPAddress?: string;

  /**
   * The test IP address type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  testIPAddressType?: EthernetAddressType;

  /**
   * The target NIC name.
   */
  targetNicName?: string;
}

/**
 * InMageRcm NIC input.
 */
model InMageRcmNicInput {
  /**
   * The NIC Id.
   */
  nicId: string;

  /**
   * A value indicating whether this is the primary NIC.
   */
  isPrimaryNic: string;

  /**
   * A value indicating whether this NIC is selected for failover.
   */
  isSelectedForFailover?: string;

  /**
   * Target subnet name.
   */
  targetSubnetName?: string;

  /**
   * The target static IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetStaticIPAddress?: string;

  /**
   * The test subnet name.
   */
  testSubnetName?: string;

  /**
   * The test static IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  testStaticIPAddress?: string;

  /**
   * The target NIC name.
   */
  targetNicName?: string;
}

/**
 * InMageRcm policy creation input.
 */
model InMageRcmPolicyCreationInput extends PolicyProviderSpecificInput {
  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistoryInMinutes?: int32;

  /**
   * The crash consistent snapshot frequency (in minutes).
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * The app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled.
   */
  enableMultiVmSync?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm specific policy details.
 */
model InMageRcmPolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistoryInMinutes?: int32;

  /**
   * The app consistent snapshot frequency in minutes.
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * The crash consistent snapshot frequency in minutes.
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled.
   */
  enableMultiVmSync?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm protected disk details.
 */
model InMageRcmProtectedDiskDetails {
  /**
   * The disk Id.
   */
  @visibility(Lifecycle.Read)
  diskId?: string;

  /**
   * The disk name.
   */
  @visibility(Lifecycle.Read)
  diskName?: string;

  /**
   * A value indicating whether the disk is the OS disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  isOSDisk?: string;

  /**
   * The disk capacity in bytes.
   */
  @visibility(Lifecycle.Read)
  capacityInBytes?: int64;

  /**
   * The disk state.
   */
  @visibility(Lifecycle.Read)
  diskState?: DiskState;

  /**
   * The log storage account ARM Id.
   */
  @visibility(Lifecycle.Read)
  logStorageAccountId?: string;

  /**
   * The DiskEncryptionSet ARM Id.
   */
  @visibility(Lifecycle.Read)
  diskEncryptionSetId?: string;

  /**
   * The ARM Id of the seed managed disk.
   */
  @visibility(Lifecycle.Read)
  seedManagedDiskId?: string;

  /**
   * The uri of the seed blob.
   */
  @visibility(Lifecycle.Read)
  seedBlobUri?: string;

  /**
   * The ARM Id of the target managed disk.
   */
  @visibility(Lifecycle.Read)
  targetManagedDiskId?: string;

  /**
   * The disk type.
   */
  diskType?: DiskAccountType;

  /**
   * The data pending in log data store in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  dataPendingInLogDataStoreInMB?: float64;

  /**
   * The data pending at source agent in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  dataPendingAtSourceAgentInMB?: float64;

  /**
   * A value indicating whether initial replication is complete or not.
   */
  @visibility(Lifecycle.Read)
  isInitialReplicationComplete?: string;

  /**
   * The initial replication details.
   */
  irDetails?: InMageRcmSyncDetails;

  /**
   * The resync details.
   */
  resyncDetails?: InMageRcmSyncDetails;

  /**
   * The custom target Azure disk name.
   */
  customTargetDiskName?: string;

  /**
   * The logical sector size (in bytes), 512 by default.
   */
  sectorSizeInBytes?: int32;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * InMageRcm disk level sync details.
 */
model InMageRcmSyncDetails {
  /**
   * The progress health.
   */
  @visibility(Lifecycle.Read)
  progressHealth?: DiskReplicationProgressHealth;

  /**
   * The transferred bytes from source VM to azure for the disk.
   */
  @visibility(Lifecycle.Read)
  transferredBytes?: int64;

  /**
   * The bytes transferred in last 15 minutes from source VM to azure.
   */
  @visibility(Lifecycle.Read)
  last15MinutesTransferredBytes?: int64;

  /**
   * The time of the last data transfer from source VM to azure.
   */
  @visibility(Lifecycle.Read)
  lastDataTransferTimeUtc?: string;

  /**
   * The total processed bytes. This includes bytes that are transferred from source VM to azure and matched bytes.
   */
  @visibility(Lifecycle.Read)
  processedBytes?: int64;

  /**
   * The start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The last refresh time.
   */
  @visibility(Lifecycle.Read)
  lastRefreshTime?: string;

  /**
   * Progress in percentage. Progress percentage is calculated based on processed bytes.
   */
  @visibility(Lifecycle.Read)
  progressPercentage?: int32;
}

/**
 * InMageRcm un-protected disk details.
 */
model InMageRcmUnProtectedDiskDetails {
  /**
   * The disk Id.
   */
  @visibility(Lifecycle.Read)
  diskId?: string;

  /**
   * The disk name.
   */
  @visibility(Lifecycle.Read)
  diskName?: string;

  /**
   * The disk capacity in bytes.
   */
  @visibility(Lifecycle.Read)
  capacityInBytes?: int64;
}

/**
 * InMageRcm provider specific container mapping details.
 */
model InMageRcmProtectionContainerMappingDetails
  extends ProtectionContainerMappingProviderSpecificDetails {
  /**
   * A value indicating whether the flag for enable agent auto upgrade.
   */
  @visibility(Lifecycle.Read)
  enableAgentAutoUpgrade?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm provider specific recovery point details.
 */
model InMageRcmRecoveryPointDetails
  extends ProviderSpecificRecoveryPointDetails {
  /**
   * A value indicating whether the recovery point is multi VM consistent.
   */
  @visibility(Lifecycle.Read)
  isMultiVmSyncPoint?: string;

  /**
   * Gets the provider type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm provider specific details.
 */
model InMageRcmReplicationDetails extends ReplicationProviderSpecificSettings {
  /**
   * The virtual machine internal identifier.
   */
  @visibility(Lifecycle.Read)
  internalIdentifier?: string;

  /**
   * The ARM Id of the discovered VM.
   */
  @visibility(Lifecycle.Read)
  fabricDiscoveryMachineId?: string;

  /**
   * The multi VM group name.
   */
  @visibility(Lifecycle.Read)
  multiVmGroupName?: string;

  /**
   * The type of the discovered VM.
   */
  @visibility(Lifecycle.Read)
  discoveryType?: string;

  /**
   * The process server Id.
   */
  @visibility(Lifecycle.Read)
  processServerId?: string;

  /**
   * The processor core count.
   */
  @visibility(Lifecycle.Read)
  processorCoreCount?: int32;

  /**
   * The allocated memory in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  allocatedMemoryInMB?: float64;

  /**
   * The process server name.
   */
  @visibility(Lifecycle.Read)
  processServerName?: string;

  /**
   * The run-as account Id.
   */
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  /**
   * The type of the OS on the VM.
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * The firmware type.
   */
  @visibility(Lifecycle.Read)
  firmwareType?: string;

  /**
   * The IP address of the primary network interface.
   */
  @visibility(Lifecycle.Read)
  primaryNicIpAddress?: string;

  /**
   * The target generation.
   */
  @visibility(Lifecycle.Read)
  targetGeneration?: string;

  /**
   * License Type of the VM to be used.
   */
  licenseType?: string;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * The replication storage account ARM Id. This is applicable only for the blob based replication test hook.
   */
  @visibility(Lifecycle.Read)
  storageAccountId?: string;

  /**
   * Target VM name.
   */
  targetVmName?: string;

  /**
   * The target VM size.
   */
  targetVmSize?: string;

  /**
   * The target resource group Id.
   */
  targetResourceGroupId?: string;

  /**
   * The target location.
   */
  targetLocation?: string;

  /**
   * The target availability set Id.
   */
  targetAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target proximity placement group Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * The target boot diagnostics storage account ARM Id.
   */
  targetBootDiagnosticsStorageAccountId?: string;

  /**
   * The target network Id.
   */
  targetNetworkId?: string;

  /**
   * The test network Id.
   */
  testNetworkId?: string;

  /**
   * The recovery point Id to which the VM was failed over.
   */
  @visibility(Lifecycle.Read)
  failoverRecoveryPointId?: string;

  /**
   * The last recovery point received time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  /**
   * The last recovery point objective value.
   */
  @visibility(Lifecycle.Read)
  lastRpoInSeconds?: int64;

  /**
   * The last recovery point objective calculated time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The last recovery point Id.
   */
  @visibility(Lifecycle.Read)
  lastRecoveryPointId?: string;

  /**
   * The initial replication progress percentage. This is calculated based on total bytes processed for all disks in the source VM.
   */
  @visibility(Lifecycle.Read)
  initialReplicationProgressPercentage?: int32;

  /**
   * The initial replication processed bytes. This includes sum of total bytes transferred and matched bytes on all selected disks in source VM.
   */
  @visibility(Lifecycle.Read)
  initialReplicationProcessedBytes?: int64;

  /**
   * The initial replication transferred bytes from source VM to azure for all selected disks on source VM.
   */
  @visibility(Lifecycle.Read)
  initialReplicationTransferredBytes?: int64;

  /**
   * The initial replication progress health.
   */
  @visibility(Lifecycle.Read)
  initialReplicationProgressHealth?: VmReplicationProgressHealth;

  /**
   * The resync progress percentage. This is calculated based on total bytes processed for all disks in the source VM.
   */
  @visibility(Lifecycle.Read)
  resyncProgressPercentage?: int32;

  /**
   * The resync processed bytes. This includes sum of total bytes transferred and matched bytes on all selected disks in source VM.
   */
  @visibility(Lifecycle.Read)
  resyncProcessedBytes?: int64;

  /**
   * The resync transferred bytes from source VM to azure for all selected disks on source VM.
   */
  @visibility(Lifecycle.Read)
  resyncTransferredBytes?: int64;

  /**
   * The resync progress health.
   */
  @visibility(Lifecycle.Read)
  resyncProgressHealth?: VmReplicationProgressHealth;

  /**
   * A value indicating whether resync is required.
   */
  @visibility(Lifecycle.Read)
  resyncRequired?: string;

  /**
   * The resync state.
   */
  @visibility(Lifecycle.Read)
  resyncState?: ResyncState;

  /**
   * The agent auto upgrade state.
   */
  @visibility(Lifecycle.Read)
  agentUpgradeState?: MobilityAgentUpgradeState;

  /**
   * The last agent upgrade type.
   */
  @visibility(Lifecycle.Read)
  lastAgentUpgradeType?: string;

  /**
   * The agent upgrade job Id.
   */
  @visibility(Lifecycle.Read)
  agentUpgradeJobId?: string;

  /**
   * The agent version to which last agent upgrade was attempted.
   */
  @visibility(Lifecycle.Read)
  agentUpgradeAttemptToVersion?: string;

  /**
   * The list of protected disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedDisks?: InMageRcmProtectedDiskDetails[];

  /**
   * The list of unprotected disks.
   */
  @identifiers(#["diskId"])
  unprotectedDisks?: InMageRcmUnProtectedDiskDetails[];

  /**
   * A value indicating whether last agent upgrade was successful or not.
   */
  @visibility(Lifecycle.Read)
  isLastUpgradeSuccessful?: string;

  /**
   * A value indicating whether agent registration was successful after failover.
   */
  @visibility(Lifecycle.Read)
  isAgentRegistrationSuccessfulAfterFailover?: boolean;

  /**
   * The mobility agent information.
   */
  mobilityAgentDetails?: InMageRcmMobilityAgentDetails;

  /**
   * The last agent upgrade error information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastAgentUpgradeErrorDetails?: InMageRcmLastAgentUpgradeErrorDetails[];

  /**
   * The agent upgrade blocking error information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agentUpgradeBlockingErrorDetails?: InMageRcmAgentUpgradeBlockingErrorDetails[];

  /**
   * The network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: InMageRcmNicDetails[];

  /**
   * The discovered VM details.
   */
  discoveredVmDetails?: InMageRcmDiscoveredProtectedVmDetails;

  /**
   * The target VM tags.
   */
  @identifiers(#["tagName"])
  targetVmTags?: UserCreatedResourceTag[];

  /**
   * The tags for the seed managed disks.
   */
  @identifiers(#["tagName"])
  seedManagedDiskTags?: UserCreatedResourceTag[];

  /**
   * The tags for the target managed disks.
   */
  @identifiers(#["tagName"])
  targetManagedDiskTags?: UserCreatedResourceTag[];

  /**
   * The tags for the target NICs.
   */
  @identifiers(#["tagName"])
  targetNicTags?: UserCreatedResourceTag[];

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: string;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportedOSVersions?: string[];

  /**
   * The OS name associated with VM.
   */
  osName?: string;

  /**
   * The target VM security profile.
   */
  targetVmSecurityProfile?: SecurityProfileProperties;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * Gets the Instance type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm specific provider input.
 */
model InMageRcmReprotectInput extends ReverseReplicationProviderSpecificInput {
  /**
   * The reprotect agent Id.
   */
  reprotectAgentId: string;

  /**
   * The target datastore name.
   */
  datastoreName: string;

  /**
   * The log storage account ARM Id.
   */
  logStorageAccountId: string;

  /**
   * The Policy Id.
   */
  policyId?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm provider specific input for test failover.
 */
model InMageRcmTestFailoverInput extends TestFailoverProviderSpecificInput {
  /**
   * The test network Id.
   */
  networkId?: string;

  /**
   * The recovery point id to be passed to test failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  osUpgradeVersion?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm provider specific input for unplanned failover.
 */
model InMageRcmUnplannedFailoverInput
  extends UnplannedFailoverProviderSpecificInput {
  /**
   * A value indicating whether VM is to be shutdown.
   */
  performShutdown: string;

  /**
   * The recovery point id to be passed to failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  osUpgradeVersion?: string;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm provider specific input to update appliance for replication protected item.
 */
model InMageRcmUpdateApplianceForReplicationProtectedItemInput
  extends UpdateApplianceForReplicationProtectedItemProviderSpecificInput {
  /**
   * The run as account Id.
   */
  runAsAccountId?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm update protection container mapping.
 */
model InMageRcmUpdateContainerMappingInput
  extends ReplicationProviderSpecificUpdateContainerMappingInput {
  /**
   * A value indicating whether agent auto upgrade has to be enabled.
   */
  enableAgentAutoUpgrade: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMageRcm provider specific input to update replication protected item.
 */
model InMageRcmUpdateReplicationProtectedItemInput
  extends UpdateReplicationProtectedItemProviderInput {
  /**
   * The target VM name.
   */
  targetVmName?: string;

  /**
   * The target VM size.
   */
  targetVmSize?: string;

  /**
   * The target resource group ARM Id.
   */
  targetResourceGroupId?: string;

  /**
   * The target availability set ARM Id.
   */
  targetAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target proximity placement group Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * The target boot diagnostics storage account ARM Id.
   */
  targetBootDiagnosticsStorageAccountId?: string;

  /**
   * The target network ARM Id.
   */
  targetNetworkId?: string;

  /**
   * The test network ARM Id.
   */
  testNetworkId?: string;

  /**
   * The list of NIC details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: InMageRcmNicInput[];

  /**
   * The license type.
   */
  licenseType?: LicenseType;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * The OS name selected by user.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userSelectedOSName?: string;

  /**
   * The target VM tags.
   */
  @identifiers(#["tagName"])
  targetVmTags?: UserCreatedResourceTag[];

  /**
   * The tags for the target managed disks.
   */
  @identifiers(#["tagName"])
  targetManagedDiskTags?: UserCreatedResourceTag[];

  /**
   * The tags for the target NICs.
   */
  @identifiers(#["tagName"])
  targetNicTags?: UserCreatedResourceTag[];

  /**
   * The list of disk update properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: UpdateDiskInput[];

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * InMage provider specific settings.
 */
model InMageReplicationDetails extends ReplicationProviderSpecificSettings {
  /**
   * The active location of the VM. If the VM is being protected from Azure, this field will take values from { Azure, OnPrem }. If the VM is being protected between two data-centers, this field will be OnPrem always.
   */
  activeSiteType?: string;

  /**
   * The CPU count of the VM on the primary side.
   */
  sourceVmCpuCount?: int32;

  /**
   * The RAM size of the VM on the primary side.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceVmRamSizeInMB?: int32;

  /**
   * The OS details.
   */
  osDetails?: OSDiskDetails;

  /**
   * The protection stage.
   */
  protectionStage?: string;

  /**
   * The virtual machine Id.
   */
  vmId?: string;

  /**
   * The protection state for the vm.
   */
  vmProtectionState?: string;

  /**
   * The protection state description for the vm.
   */
  vmProtectionStateDescription?: string;

  /**
   * The resync details of the machine.
   */
  resyncDetails?: InitialReplicationDetails;

  /**
   * The retention window start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retentionWindowStart?: utcDateTime;

  /**
   * The retention window end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retentionWindowEnd?: utcDateTime;

  /**
   * The compressed data change rate in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  compressedDataRateInMB?: float64;

  /**
   * The uncompressed data change rate in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  uncompressedDataRateInMB?: float64;

  /**
   * The RPO in seconds.
   */
  rpoInSeconds?: int64;

  /**
   * The list of protected disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedDisks?: InMageProtectedDiskDetails[];

  /**
   * The source IP address.
   */
  ipAddress?: string;

  /**
   * The last heartbeat received from the source server.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * The process server Id.
   */
  processServerId?: string;

  /**
   * The master target Id.
   */
  masterTargetId?: string;

  /**
   * The collection of Consistency points.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  consistencyPoints?: Record<utcDateTime>;

  /**
   * A value indicating whether any disk is resized for this VM.
   */
  diskResized?: string;

  /**
   * A value indicating whether the source server requires a restart after update.
   */
  rebootAfterUpdateStatus?: string;

  /**
   * The multi vm group Id, if any.
   */
  multiVmGroupId?: string;

  /**
   * The multi vm group name, if any.
   */
  multiVmGroupName?: string;

  /**
   * A value indicating whether the multi vm sync is enabled or disabled.
   */
  multiVmSyncStatus?: string;

  /**
   * The agent details.
   */
  agentDetails?: InMageAgentDetails;

  /**
   * The vCenter infrastructure Id.
   */
  vCenterInfrastructureId?: string;

  /**
   * The infrastructure VM Id.
   */
  infrastructureVmId?: string;

  /**
   * The PE Network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMNicDetails[];

  /**
   * A value indicating the discovery type of the machine.
   */
  discoveryType?: string;

  /**
   * A value indicating the underlying Azure storage account. If the VM is not running in Azure, this value shall be set to null.
   */
  azureStorageAccountId?: string;

  /**
   * The datastores of the on-premise machine Value can be list of strings that contain datastore names.
   */
  datastores?: string[];

  /**
   * The validation errors of the on-premise machine Value can be list of validation errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationErrors?: HealthError[];

  /**
   * The last RPO calculated time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRpoCalculatedTime?: utcDateTime;

  /**
   * The last update time received from on-prem components.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateReceivedTime?: utcDateTime;

  /**
   * The replica id of the protected item.
   */
  replicaId?: string;

  /**
   * The OS Version of the protected item.
   */
  osVersion?: string;

  /**
   * A value indicating whether additional IR stats are available or not.
   */
  isAdditionalStatsAvailable?: boolean;

  /**
   * The total transferred data in bytes.
   */
  totalDataTransferred?: int64;

  /**
   * The progress health.
   */
  totalProgressHealth?: string;

  /**
   * Gets the Instance type.
   */
  instanceType: "InMage";
}

/**
 * Details of the OS Disk.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OSDiskDetails {
  /**
   * The id of the disk containing the OS.
   */
  osVhdId?: string;

  /**
   * The type of the OS on the VM.
   */
  osType?: string;

  /**
   * The OS disk VHD name.
   */
  vhdName?: string;
}

/**
 * InMageAzureV2 specific provider input.
 */
model InMageReprotectInput extends ReverseReplicationProviderSpecificInput {
  /**
   * The Master Target Id.
   */
  masterTargetId: string;

  /**
   * The Process Server Id.
   */
  processServerId: string;

  /**
   * The retention drive to use on the MT.
   */
  retentionDrive: string;

  /**
   * The CS account Id.
   */
  runAsAccountId?: string;

  /**
   * The target datastore name.
   */
  datastoreName?: string;

  /**
   * The enable disk exclusion input.
   */
  diskExclusionInput?: InMageDiskExclusionInput;

  /**
   * The Policy Id.
   */
  profileId: string;

  /**
   * The disks to include list.
   */
  disksToInclude?: string[];

  /**
   * The class type.
   */
  instanceType: "InMage";
}

/**
 * Provider specific input for InMage test failover.
 */
model InMageTestFailoverInput extends TestFailoverProviderSpecificInput {
  /**
   * The recovery point type. Values from LatestTime, LatestTag or Custom. In the case of custom, the recovery point provided by RecoveryPointId will be used. In the other two cases, recovery point id will be ignored.
   */
  recoveryPointType?: RecoveryPointType;

  /**
   * The recovery point id to be passed to test failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * The class type.
   */
  instanceType: "InMage";
}

/**
 * Provider specific input for InMage unplanned failover.
 */
model InMageUnplannedFailoverInput
  extends UnplannedFailoverProviderSpecificInput {
  /**
   * The recovery point type. Values from LatestTime, LatestTag or Custom. In the case of custom, the recovery point provided by RecoveryPointId will be used. In the other two cases, recovery point id will be ignored.
   */
  recoveryPointType?: RecoveryPointType;

  /**
   * The recovery point id to be passed to failover to a particular recovery point. In case of latest recovery point, null should be passed.
   */
  recoveryPointId?: string;

  /**
   * The class type.
   */
  instanceType: "InMage";
}

/**
 * Model class for event details of a job status event.
 */
model JobStatusEventDetails extends EventSpecificDetails {
  /**
   * Job arm id for the event.
   */
  jobId?: string;

  /**
   * JobName for the Event.
   */
  jobFriendlyName?: string;

  /**
   * JobStatus for the Event.
   */
  jobStatus?: string;

  /**
   * AffectedObjectType for the event.
   */
  affectedObjectType?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "JobStatus";
}

/**
 * Managed RunCommand script input
 */
model ManagedRunCommandScriptInput {
  /**
   * The step name.
   */
  stepName: string;

  /**
   * The script url.
   */
  scriptUrl: string;

  /**
   * The script parameters.
   */
  scriptParameters: string;
}

/**
 * This class represents the manual action task details.
 */
model ManualActionTaskDetails extends TaskTypeDetails {
  /**
   * The name.
   */
  name?: string;

  /**
   * The instructions.
   */
  instructions?: string;

  /**
   * The observation.
   */
  observation?: string;

  /**
   * The type of task details.
   */
  instanceType: "ManualActionTaskDetails";
}

/**
 * Details of a Master Target Server.
 */
model MasterTargetServer {
  /**
   * The server Id.
   */
  id?: string;

  /**
   * The IP address of the server.
   */
  ipAddress?: string;

  /**
   * The server name.
   */
  name?: string;

  /**
   * The OS type of the server.
   */
  osType?: string;

  /**
   * The version of the scout component on the server.
   */
  agentVersion?: string;

  /**
   * The last heartbeat received from the server.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * Version status.
   */
  versionStatus?: string;

  /**
   * The retention volumes of Master target Server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retentionVolumes?: RetentionVolume[];

  /**
   * The list of data stores in the fabric.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataStores?: DataStore[];

  /**
   * Validation errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationErrors?: HealthError[];

  /**
   * Health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrors?: HealthError[];

  /**
   * Disk count of the master target.
   */
  diskCount?: int32;

  /**
   * OS Version of the master target.
   */
  osVersion?: string;

  /**
   * Agent expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentExpiryDate?: utcDateTime;

  /**
   * MARS agent version.
   */
  marsAgentVersion?: string;

  /**
   * MARS agent expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  marsAgentExpiryDate?: utcDateTime;

  /**
   * Agent version details.
   */
  agentVersionDetails?: VersionDetails;

  /**
   * Mars agent version details.
   */
  marsAgentVersionDetails?: VersionDetails;
}

/**
 * The retention details of the MT.
 */
model RetentionVolume {
  /**
   * The volume name.
   */
  volumeName?: string;

  /**
   * The volume capacity.
   */
  capacityInBytes?: int64;

  /**
   * The free space available in this volume.
   */
  freeSpaceInBytes?: int64;

  /**
   * The threshold percentage.
   */
  thresholdPercentage?: int32;
}

/**
 * Query parameter to enumerate migration items.
 */
model MigrationItemsQueryParameter {
  /**
   * The source fabric name filter.
   */
  sourceFabricName?: string;

  /**
   * The source container name filter.
   */
  sourceContainerName?: string;

  /**
   * The replication provider type.
   */
  instanceType?: string;
}

/**
 * The Mobility Service update details.
 */
model MobilityServiceUpdate {
  /**
   * The version of the latest update.
   */
  version?: string;

  /**
   * The reboot status of the update - whether it is required or not.
   */
  rebootStatus?: string;

  /**
   * The OS type.
   */
  osType?: string;
}

/**
 * New Protection profile input.
 */
model NewProtectionProfile extends ProtectionProfileCustomDetails {
  /**
   * The protection profile input.
   */
  policyName: string;

  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistory?: int32;

  /**
   * The crash consistent snapshot frequency (in minutes).
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * The app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * A value indicating whether multi-VM sync has to be enabled. Value should be 'Enabled' or 'Disabled'.
   */
  multiVmSyncStatus: SetMultiVmSyncStatus;

  /**
   * The class type.
   */
  resourceType: "New";
}

/**
 * Recovery virtual network input to create new virtual network from given source network.
 */
model NewRecoveryVirtualNetwork extends RecoveryVirtualNetworkCustomDetails {
  /**
   * The name of the resource group to be used to create the recovery virtual network. If absent, target network would be created in the same resource group as target VM.
   */
  recoveryVirtualNetworkResourceGroupName?: string;

  /**
   * The recovery virtual network name.
   */
  recoveryVirtualNetworkName?: string;

  /**
   * The class type.
   */
  resourceType: "New";
}

/**
 * Details of the Process Server.
 */
model ProcessServer {
  /**
   * The Process Server's friendly name.
   */
  friendlyName?: string;

  /**
   * The Process Server Id.
   */
  id?: string;

  /**
   * The IP address of the server.
   */
  ipAddress?: string;

  /**
   * The OS type of the server.
   */
  osType?: string;

  /**
   * The version of the scout component on the server.
   */
  agentVersion?: string;

  /**
   * The last heartbeat received from the server.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * Version status.
   */
  versionStatus?: string;

  /**
   * The list of the mobility service updates available on the Process Server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mobilityServiceUpdates?: MobilityServiceUpdate[];

  /**
   * The agent generated Id.
   */
  hostId?: string;

  /**
   * The servers configured with this PS.
   */
  machineCount?: string;

  /**
   * The number of replication pairs configured in this PS.
   */
  replicationPairCount?: string;

  /**
   * The percentage of the system load.
   */
  systemLoad?: string;

  /**
   * The system load status.
   */
  systemLoadStatus?: string;

  /**
   * The percentage of the CPU load.
   */
  cpuLoad?: string;

  /**
   * The CPU load status.
   */
  cpuLoadStatus?: string;

  /**
   * The total memory.
   */
  totalMemoryInBytes?: int64;

  /**
   * The available memory.
   */
  availableMemoryInBytes?: int64;

  /**
   * The memory usage status.
   */
  memoryUsageStatus?: string;

  /**
   * The total space.
   */
  totalSpaceInBytes?: int64;

  /**
   * The available space.
   */
  availableSpaceInBytes?: int64;

  /**
   * The space usage status.
   */
  spaceUsageStatus?: string;

  /**
   * The PS service status.
   */
  psServiceStatus?: string;

  /**
   * The PS SSL cert expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sslCertExpiryDate?: utcDateTime;

  /**
   * CS SSL cert expiry date.
   */
  sslCertExpiryRemainingDays?: int32;

  /**
   * OS Version of the process server. Note: This will get populated if user has CS version greater than 9.12.0.0.
   */
  osVersion?: string;

  /**
   * Health errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthErrors?: HealthError[];

  /**
   * Agent expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentExpiryDate?: utcDateTime;

  /**
   * The agent version details.
   */
  agentVersionDetails?: VersionDetails;

  /**
   * The health of Process Server.
   */
  @visibility(Lifecycle.Read)
  health?: ProtectionHealth;

  /**
   * The process server stats refresh time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  psStatsRefreshTime?: utcDateTime;

  /**
   * The uploading pending data in bytes.
   */
  @visibility(Lifecycle.Read)
  throughputUploadPendingDataInBytes?: int64;

  /**
   * The throughput in MBps.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  throughputInMBps?: int64;

  /**
   * The throughput in bytes.
   */
  @visibility(Lifecycle.Read)
  throughputInBytes?: int64;

  /**
   * The throughput status.
   */
  @visibility(Lifecycle.Read)
  throughputStatus?: string;

  /**
   * The MARS communication status.
   */
  @visibility(Lifecycle.Read)
  marsCommunicationStatus?: string;

  /**
   * The MARS registration status.
   */
  @visibility(Lifecycle.Read)
  marsRegistrationStatus?: string;
}

/**
 * Query parameter to enumerate Protectable items.
 */
model ProtectableItemQueryParameter {
  /**
   * State of the Protectable item query filter.
   */
  state?: string;
}

/**
 * Query parameter to enumerate protected items.
 */
model ProtectedItemsQueryParameter {
  /**
   * The source fabric name filter.
   */
  sourceFabricName?: string;

  /**
   * The recovery plan filter.
   */
  recoveryPlanName?: string;

  /**
   * The source fabric location filter.
   */
  sourceFabricLocation?: string;

  /**
   * The fabric object Id filter.
   */
  fabricObjectId?: string;

  /**
   * The vCenter name filter.
   */
  vCenterName?: string;

  /**
   * The replication provider type.
   */
  instanceType?: string;

  /**
   * Whether Multi VM group is auto created or specified by user.
   */
  multiVmGroupCreateOption?: MultiVmGroupCreateOption;

  /**
   * The process server Id filter.
   */
  processServerId?: string;
}

/**
 * Recovery plan A2A specific details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPlanA2ADetails extends RecoveryPlanProviderSpecificDetails {
  /**
   * The primary zone.
   */
  primaryZone?: string;

  /**
   * The recovery zone.
   */
  recoveryZone?: string;

  /**
   * The primary extended location.
   */
  primaryExtendedLocation?: ExtendedLocation;

  /**
   * The recovery extended location.
   */
  recoveryExtendedLocation?: ExtendedLocation;

  /**
   * Gets the Instance type.
   */
  instanceType: "A2A";
}

/**
 * Recovery plan A2A failover input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPlanA2AFailoverInput
  extends RecoveryPlanProviderSpecificFailoverInput {
  /**
   * The recovery point type.
   */
  recoveryPointType: A2ARpRecoveryPointType;

  /**
   * A value indicating whether to use recovery cloud service for TFO or not.
   */
  cloudServiceCreationOption?: string;

  /**
   * A value indicating whether multi VM sync enabled VMs should use multi VM sync points for failover.
   */
  multiVmSyncPointOption?: MultiVmSyncPointOption;

  /**
   * The class type.
   */
  instanceType: "A2A";
}

/**
 * Recovery plan A2A input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPlanA2AInput extends RecoveryPlanProviderSpecificInput {
  /**
   * The primary zone.
   */
  primaryZone?: string;

  /**
   * The recovery zone.
   */
  recoveryZone?: string;

  /**
   * The primary extended location.
   */
  primaryExtendedLocation?: ExtendedLocation;

  /**
   * The recovery extended location.
   */
  recoveryExtendedLocation?: ExtendedLocation;

  /**
   * Gets the Instance type.
   */
  instanceType: "A2A";
}

/**
 * Recovery plan Automation runbook action details.
 */
model RecoveryPlanAutomationRunbookActionDetails
  extends RecoveryPlanActionDetails {
  /**
   * The runbook ARM Id.
   */
  runbookId?: string;

  /**
   * The runbook timeout.
   */
  timeout?: string;

  /**
   * The fabric location.
   */
  fabricLocation: RecoveryPlanActionLocation;

  /**
   * Gets the type of action details (see RecoveryPlanActionDetailsTypes enum for possible values).
   */
  instanceType: "AutomationRunbookActionDetails";
}

/**
 * This class represents the recovery plan group task.
 */
model RecoveryPlanGroupTaskDetails extends GroupTaskDetails {
  /**
   * The name.
   */
  name?: string;

  /**
   * The group identifier.
   */
  groupId?: string;

  /**
   * The group type.
   */
  rpGroupType?: string;

  instanceType: "RecoveryPlanGroupTaskDetails";
}

/**
 * Recovery plan HVR Azure failback input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPlanHyperVReplicaAzureFailbackInput
  extends RecoveryPlanProviderSpecificFailoverInput {
  /**
   * The data sync option.
   */
  dataSyncOption: DataSyncStatus;

  /**
   * The ALR option.
   */
  recoveryVmCreationOption: AlternateLocationRecoveryOption;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzureFailback";
}

/**
 * Recovery plan HVR Azure failover input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPlanHyperVReplicaAzureFailoverInput
  extends RecoveryPlanProviderSpecificFailoverInput {
  /**
   * The primary KEK certificate PFX.
   */
  primaryKekCertificatePfx?: string;

  /**
   * The secondary KEK certificate PFX.
   */
  secondaryKekCertificatePfx?: string;

  /**
   * The recovery point type.
   */
  recoveryPointType?: HyperVReplicaAzureRpRecoveryPointType;

  /**
   * The class type.
   */
  instanceType: "HyperVReplicaAzure";
}

/**
 * Recovery plan InMageAzureV2 failover input.
 */
model RecoveryPlanInMageAzureV2FailoverInput
  extends RecoveryPlanProviderSpecificFailoverInput {
  /**
   * The recovery point type.
   */
  recoveryPointType: InMageV2RpRecoveryPointType;

  /**
   * A value indicating whether multi VM sync enabled VMs should use multi VM sync points for failover.
   */
  useMultiVmSyncPoint?: string;

  /**
   * The class type.
   */
  instanceType: "InMageAzureV2";
}

/**
 * Recovery plan InMage failover input.
 */
model RecoveryPlanInMageFailoverInput
  extends RecoveryPlanProviderSpecificFailoverInput {
  /**
   * The recovery point type.
   */
  recoveryPointType: RpInMageRecoveryPointType;

  /**
   * The class type.
   */
  instanceType: "InMage";
}

/**
 * Recovery plan InMageRcmFailback failover input.
 */
model RecoveryPlanInMageRcmFailbackFailoverInput
  extends RecoveryPlanProviderSpecificFailoverInput {
  /**
   * The recovery point type.
   */
  recoveryPointType: InMageRcmFailbackRecoveryPointType;

  /**
   * A value indicating whether multi VM sync enabled VMs should use multi VM sync points for failover.
   */
  useMultiVmSyncPoint?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcmFailback";
}

/**
 * Recovery plan InMageRcm failover input.
 */
model RecoveryPlanInMageRcmFailoverInput
  extends RecoveryPlanProviderSpecificFailoverInput {
  /**
   * The recovery point type.
   */
  recoveryPointType: RecoveryPlanPointType;

  /**
   * A value indicating whether multi VM sync enabled VMs should use multi VM sync points for failover.
   */
  useMultiVmSyncPoint?: string;

  /**
   * The class type.
   */
  instanceType: "InMageRcm";
}

/**
 * Recovery plan manual action details.
 */
model RecoveryPlanManualActionDetails extends RecoveryPlanActionDetails {
  /**
   * The manual action description.
   */
  description?: string;

  /**
   * Gets the type of action details (see RecoveryPlanActionDetailsTypes enum for possible values).
   */
  instanceType: "ManualActionDetails";
}

/**
 * Recovery plan script action details.
 */
model RecoveryPlanScriptActionDetails extends RecoveryPlanActionDetails {
  /**
   * The script path.
   */
  path: string;

  /**
   * The script timeout.
   */
  timeout?: string;

  /**
   * The fabric location.
   */
  fabricLocation: RecoveryPlanActionLocation;

  /**
   * Gets the type of action details (see RecoveryPlanActionDetailsTypes enum for possible values).
   */
  instanceType: "ScriptActionDetails";
}

/**
 * This class represents the recovery plan shutdown group task details.
 */
model RecoveryPlanShutdownGroupTaskDetails extends GroupTaskDetails {
  /**
   * The name.
   */
  name?: string;

  /**
   * The group identifier.
   */
  groupId?: string;

  /**
   * The group type.
   */
  rpGroupType?: string;

  /**
   * The type of task details.
   */
  instanceType: "RecoveryPlanShutdownGroupTaskDetails";
}

/**
 * Replication group details. This will be used in case of San.
 */
model ReplicationGroupDetails extends ConfigurationSettings {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "ReplicationGroupDetails";
}

/**
 * Query parameter to enumerate protected clusters.
 */
model ProtectedClustersQueryParameter {
  /**
   * The source fabric name filter.
   */
  sourceFabricName?: string;

  /**
   * The source fabric location filter.
   */
  sourceFabricLocation?: string;

  /**
   * The replication provider type.
   */
  instanceType?: string;
}

/**
 * Azure role assignment details.
 */
model RoleAssignment {
  /**
   * The ARM Id of the role assignment.
   */
  id?: string;

  /**
   * The name of the role assignment.
   */
  name?: string;

  /**
   * Role assignment scope.
   */
  scope?: string;

  /**
   * Principal Id.
   */
  principalId?: string;

  /**
   * Role definition id.
   */
  roleDefinitionId?: string;
}

/**
 * CS Accounts Details.
 */
model RunAsAccount {
  /**
   * The CS RunAs account Id.
   */
  accountId?: string;

  /**
   * The CS RunAs account name.
   */
  accountName?: string;
}

/**
 * This class represents the script action task details.
 */
model ScriptActionTaskDetails extends TaskTypeDetails {
  /**
   * The name.
   */
  name?: string;

  /**
   * The path.
   */
  path?: string;

  /**
   * The output.
   */
  output?: string;

  /**
   * A value indicating whether it is a primary side script or not.
   */
  isPrimarySideScript?: boolean;

  /**
   * The type of task details.
   */
  instanceType: "ScriptActionTaskDetails";
}

/**
 * This class represents details for switch protection job.
 */
model SwitchProtectionJobDetails extends JobDetails {
  /**
   * ARM Id of the new replication protected item.
   */
  newReplicationProtectedItemId?: string;

  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  instanceType: "SwitchProtectionJobDetails";
}

/**
 * This class represents the details for a test failover job.
 */
model TestFailoverJobDetails extends JobDetails {
  /**
   * The test failover status.
   */
  testFailoverStatus?: string;

  /**
   * The test failover comments.
   */
  comments?: string;

  /**
   * The test network name.
   */
  networkName?: string;

  /**
   * The test network friendly name.
   */
  networkFriendlyName?: string;

  /**
   * The test network type (see TestFailoverInput enum for possible values).
   */
  networkType?: string;

  /**
   * The test VM details.
   */
  protectedItemDetails?: FailoverReplicationProtectedItemDetails[];

  /**
   * Gets the type of job details (see JobDetailsTypes enum for possible values).
   */
  instanceType: "TestFailoverJobDetails";
}

/**
 * This class represents the virtual machine task details.
 */
model VirtualMachineTaskDetails extends TaskTypeDetails {
  /**
   * The skipped reason.
   */
  skippedReason?: string;

  /**
   * The skipped reason string.
   */
  skippedReasonString?: string;

  /**
   * The job entity.
   */
  jobTask?: JobEntity;

  /**
   * The type of task details.
   */
  instanceType: "VirtualMachineTaskDetails";
}

/**
 * VMM fabric specific details.
 */
model VmmDetails extends FabricSpecificDetails {
  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "VMM";
}

/**
 * Create network mappings input properties/behavior specific to Vmm to Azure Network mapping.
 */
model VmmToAzureCreateNetworkMappingInput
  extends FabricSpecificCreateNetworkMappingInput {
  /**
   * The instance type.
   */
  instanceType: "VmmToAzure";
}

/**
 * E2A Network Mapping fabric specific settings.
 */
model VmmToAzureNetworkMappingSettings
  extends NetworkMappingFabricSpecificSettings {
  /**
   * Gets the Instance type.
   */
  instanceType: "VmmToAzure";
}

/**
 * Update network mappings input properties/behavior specific to vmm to azure.
 */
model VmmToAzureUpdateNetworkMappingInput
  extends FabricSpecificUpdateNetworkMappingInput {
  /**
   * The instance type.
   */
  instanceType: "VmmToAzure";
}

/**
 * Create network mappings input properties/behavior specific to vmm to vmm Network mapping.
 */
model VmmToVmmCreateNetworkMappingInput
  extends FabricSpecificCreateNetworkMappingInput {
  /**
   * The instance type.
   */
  instanceType: "VmmToVmm";
}

/**
 * E2E Network Mapping fabric specific settings.
 */
model VmmToVmmNetworkMappingSettings
  extends NetworkMappingFabricSpecificSettings {
  /**
   * Gets the Instance type.
   */
  instanceType: "VmmToVmm";
}

/**
 * Update network mappings input properties/behavior specific to vmm to vmm.
 */
model VmmToVmmUpdateNetworkMappingInput
  extends FabricSpecificUpdateNetworkMappingInput {
  /**
   * The instance type.
   */
  instanceType: "VmmToVmm";
}

/**
 * VMM fabric provider specific VM settings.
 */
model VmmVirtualMachineDetails extends ConfigurationSettings {
  /**
   * The source id of the object.
   */
  sourceItemId?: string;

  /**
   * The id of the object in fabric.
   */
  generation?: string;

  /**
   * The Last replication time.
   */
  osDetails?: OSDetails;

  /**
   * The Last successful failover time.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskDetails?: DiskDetails[];

  /**
   * A value indicating whether the VM has a physical disk attached. String value of SrsDataContract.PresenceStatus enum.
   */
  hasPhysicalDisk?: PresenceStatus;

  /**
   * A value indicating whether the VM has a fibre channel adapter attached. String value of SrsDataContract.PresenceStatus enum.
   */
  hasFibreChannelAdapter?: PresenceStatus;

  /**
   * A value indicating whether the VM has a shared VHD attached. String value of SrsDataContract.PresenceStatus enum.
   */
  hasSharedVhd?: PresenceStatus;

  /**
   * The Id of the hyper-v host in fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hyperVHostId?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "VmmVirtualMachine";
}

/**
 * This class represents the vm NicUpdates task details.
 */
model VmNicUpdatesTaskDetails extends TaskTypeDetails {
  /**
   * Virtual machine Id.
   */
  vmId?: string;

  /**
   * Nic Id.
   */
  nicId?: string;

  /**
   * Name of the Nic.
   */
  name?: string;

  /**
   * The type of task details.
   */
  instanceType: "VmNicUpdatesTaskDetails";
}

/**
 * VMwareCbt container creation input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtContainerCreationInput
  extends ReplicationProviderSpecificContainerCreationInput {
  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt container mapping input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtContainerMappingInput
  extends ReplicationProviderSpecificContainerMappingInput {
  /**
   * The target key vault ARM Id.
   */
  keyVaultId?: string;

  /**
   * The target key vault URL.
   */
  keyVaultUri?: string;

  /**
   * The storage account ARM Id.
   */
  storageAccountId: string;

  /**
   * The secret name of the storage account.
   */
  storageAccountSasSecretName?: string;

  /**
   * The secret name of the service bus connection string.
   */
  serviceBusConnectionStringSecretName?: string;

  /**
   * The target location.
   */
  targetLocation: string;

  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt disk input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtDiskInput {
  /**
   * The disk Id.
   */
  diskId: string;

  /**
   * The disk type.
   */
  diskType?: DiskAccountType;

  /**
   * A value indicating whether the disk is the OS disk.
   */
  isOSDisk: string;

  /**
   * The log storage account ARM Id.
   */
  logStorageAccountId: string;

  /**
   * The key vault secret name of the log storage account.
   */
  logStorageAccountSasSecretName: string;

  /**
   * The DiskEncryptionSet ARM Id.
   */
  diskEncryptionSetId?: string;

  /**
   * The logical sector size (in bytes), 512 by default.
   */
  sectorSizeInBytes?: int32;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * VMwareCbt specific enable migration input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtEnableMigrationInput
  extends EnableMigrationProviderSpecificInput {
  /**
   * The ARM Id of the VM discovered in VMware.
   */
  vmwareMachineId: string;

  /**
   * The disks to include list.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disksToInclude: VMwareCbtDiskInput[];

  /**
   * License type.
   */
  licenseType?: LicenseType;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * A value indicating whether bulk SQL RP registration to be done.
   */
  performSqlBulkRegistration?: string;

  /**
   * The data mover run as account Id.
   */
  dataMoverRunAsAccountId: string;

  /**
   * The snapshot run as account Id.
   */
  snapshotRunAsAccountId: string;

  /**
   * The target VM name.
   */
  targetVmName?: string;

  /**
   * The target VM size.
   */
  targetVmSize?: string;

  /**
   * The target resource group ARM Id.
   */
  targetResourceGroupId: string;

  /**
   * The target network ARM Id.
   */
  targetNetworkId: string;

  /**
   * The selected test network ARM Id.
   */
  testNetworkId?: string;

  /**
   * The target subnet name.
   */
  targetSubnetName?: string;

  /**
   * The selected test subnet name.
   */
  testSubnetName?: string;

  /**
   * The target availability set ARM Id.
   */
  targetAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target proximity placement group ARM Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * The confidential VM key vault Id for ADE installation.
   */
  confidentialVmKeyVaultId?: string;

  /**
   * The target VM security profile.
   */
  targetVmSecurityProfile?: VMwareCbtSecurityProfileProperties;

  /**
   * The target boot diagnostics storage account ARM Id.
   */
  targetBootDiagnosticsStorageAccountId?: string;

  /**
   * A value indicating whether auto resync is to be done.
   */
  performAutoResync?: string;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The tags for the seed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  seedDiskTags?: Record<string>;

  /**
   * The tags for the target disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetDiskTags?: Record<string>;

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The OS name selected by user.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userSelectedOSName?: string;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt security profile input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtSecurityProfileProperties {
  /**
   * The target VM security type.
   */
  targetVmSecurityType?: SecurityType;

  /**
   * A value indicating whether secure boot to be enabled.
   */
  isTargetVmSecureBootEnabled?: string;

  /**
   * A value indicating whether trusted platform module to be enabled.
   */
  isTargetVmTpmEnabled?: string;

  /**
   * A value indicating whether integrity monitoring to be enabled.
   */
  isTargetVmIntegrityMonitoringEnabled?: string;

  /**
   * A value indicating whether confidential compute encryption to be enabled.
   */
  isTargetVmConfidentialEncryptionEnabled?: string;
}

/**
 * Event details for VMwareCbt provider.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtEventDetails extends EventProviderSpecificDetails {
  /**
   * The migration item name.
   */
  @visibility(Lifecycle.Read)
  migrationItemName?: string;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt specific migrate input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtMigrateInput extends MigrateProviderSpecificInput {
  /**
   * A value indicating whether VM is to be shutdown.
   */
  performShutdown: string;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  osUpgradeVersion?: string;

  /**
   * The managed run command script input.
   */
  @identifiers(#["stepName"])
  postMigrationSteps?: ManagedRunCommandScriptInput[];

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtMigrationDetails extends MigrationProviderSpecificSettings {
  /**
   * The ARM Id of the VM discovered in VMware.
   */
  @visibility(Lifecycle.Read)
  vmwareMachineId?: string;

  /**
   * The type of the OS on the VM.
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * The name of the OS on the VM.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * The firmware type.
   */
  @visibility(Lifecycle.Read)
  firmwareType?: string;

  /**
   * The target generation.
   */
  @visibility(Lifecycle.Read)
  targetGeneration?: string;

  /**
   * License Type of the VM to be used.
   */
  licenseType?: string;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: string;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * The data mover run as account Id.
   */
  @visibility(Lifecycle.Read)
  dataMoverRunAsAccountId?: string;

  /**
   * The snapshot run as account Id.
   */
  @visibility(Lifecycle.Read)
  snapshotRunAsAccountId?: string;

  /**
   * The replication storage account ARM Id. This is applicable only for the blob based replication test hook.
   */
  @visibility(Lifecycle.Read)
  storageAccountId?: string;

  /**
   * Target VM name.
   */
  targetVmName?: string;

  /**
   * The target VM size.
   */
  targetVmSize?: string;

  /**
   * The target location.
   */
  @visibility(Lifecycle.Read)
  targetLocation?: string;

  /**
   * The target resource group Id.
   */
  targetResourceGroupId?: string;

  /**
   * The target availability set Id.
   */
  targetAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target proximity placement group Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * The confidential VM key vault Id for ADE installation.
   */
  confidentialVmKeyVaultId?: string;

  /**
   * The target VM security profile.
   */
  targetVmSecurityProfile?: VMwareCbtSecurityProfileProperties;

  /**
   * The target boot diagnostics storage account ARM Id.
   */
  targetBootDiagnosticsStorageAccountId?: string;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The list of protected disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedDisks?: VMwareCbtProtectedDiskDetails[];

  /**
   * The target network Id.
   */
  targetNetworkId?: string;

  /**
   * The test network Id.
   */
  testNetworkId?: string;

  /**
   * The network details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMwareCbtNicDetails[];

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The recovery point Id to which the VM was migrated.
   */
  @visibility(Lifecycle.Read)
  migrationRecoveryPointId?: string;

  /**
   * The last recovery point received time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  /**
   * The last recovery point Id.
   */
  @visibility(Lifecycle.Read)
  lastRecoveryPointId?: string;

  /**
   * The initial seeding progress percentage.
   */
  @visibility(Lifecycle.Read)
  initialSeedingProgressPercentage?: int32;

  /**
   * The migration progress percentage.
   */
  @visibility(Lifecycle.Read)
  migrationProgressPercentage?: int32;

  /**
   * The resync progress percentage.
   */
  @visibility(Lifecycle.Read)
  resyncProgressPercentage?: int32;

  /**
   * The resume progress percentage.
   */
  @visibility(Lifecycle.Read)
  resumeProgressPercentage?: int32;

  /**
   * The delta sync progress percentage.
   */
  @visibility(Lifecycle.Read)
  deltaSyncProgressPercentage?: int32;

  /**
   * A value indicating whether checksum resync cycle is in progress.
   */
  @visibility(Lifecycle.Read)
  isCheckSumResyncCycle?: string;

  /**
   * The initial seeding retry count.
   */
  @visibility(Lifecycle.Read)
  initialSeedingRetryCount?: int64;

  /**
   * The resync retry count.
   */
  @visibility(Lifecycle.Read)
  resyncRetryCount?: int64;

  /**
   * The resume retry count.
   */
  @visibility(Lifecycle.Read)
  resumeRetryCount?: int64;

  /**
   * The delta sync retry count.
   */
  @visibility(Lifecycle.Read)
  deltaSyncRetryCount?: int64;

  /**
   * A value indicating whether resync is required.
   */
  @visibility(Lifecycle.Read)
  resyncRequired?: string;

  /**
   * The resync state.
   */
  @visibility(Lifecycle.Read)
  resyncState?: ResyncState;

  /**
   * A value indicating whether auto resync is to be done.
   */
  performAutoResync?: string;

  /**
   * The tags for the seed disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  seedDiskTags?: Record<string>;

  /**
   * The tags for the target disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetDiskTags?: Record<string>;

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportedOSVersions?: string[];

  /**
   * A value indicating the appliance monitoring details.
   */
  @visibility(Lifecycle.Read)
  applianceMonitoringDetails?: ApplianceMonitoringDetails;

  /**
   * A value indicating the gateway operation details.
   */
  @visibility(Lifecycle.Read)
  gatewayOperationDetails?: GatewayOperationDetails;

  /**
   * A value indicating the SRS operation name.
   */
  @visibility(Lifecycle.Read)
  operationName?: string;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * Gets the instance type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt protected disk details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtProtectedDiskDetails {
  /**
   * The disk id.
   */
  @visibility(Lifecycle.Read)
  diskId?: string;

  /**
   * The disk name.
   */
  @visibility(Lifecycle.Read)
  diskName?: string;

  /**
   * The disk type.
   */
  diskType?: DiskAccountType;

  /**
   * The disk path.
   */
  @visibility(Lifecycle.Read)
  diskPath?: string;

  /**
   * A value indicating whether the disk is the OS disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  isOSDisk?: string;

  /**
   * The disk capacity in bytes.
   */
  @visibility(Lifecycle.Read)
  capacityInBytes?: int64;

  /**
   * The log storage account ARM Id.
   */
  @visibility(Lifecycle.Read)
  logStorageAccountId?: string;

  /**
   * The key vault secret name of the log storage account.
   */
  @visibility(Lifecycle.Read)
  logStorageAccountSasSecretName?: string;

  /**
   * The DiskEncryptionSet ARM Id.
   */
  @visibility(Lifecycle.Read)
  diskEncryptionSetId?: string;

  /**
   * The ARM Id of the seed managed disk.
   */
  @visibility(Lifecycle.Read)
  seedManagedDiskId?: string;

  /**
   * The uri of the seed blob.
   */
  @visibility(Lifecycle.Read)
  seedBlobUri?: string;

  /**
   * The ARM Id of the target managed disk.
   */
  @visibility(Lifecycle.Read)
  targetManagedDiskId?: string;

  /**
   * The uri of the target blob.
   */
  @visibility(Lifecycle.Read)
  targetBlobUri?: string;

  /**
   * The name for the target managed disk.
   */
  targetDiskName?: string;

  /**
   * A value indicating the gateway operation details.
   */
  @visibility(Lifecycle.Read)
  gatewayOperationDetails?: GatewayOperationDetails;

  /**
   * The logical sector size (in bytes), 512 by default.
   */
  sectorSizeInBytes?: int32;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * VMwareCbt NIC details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtNicDetails {
  /**
   * The NIC Id.
   */
  @visibility(Lifecycle.Read)
  nicId?: string;

  /**
   * A value indicating whether this is the primary NIC.
   */
  isPrimaryNic?: string;

  /**
   * The source IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sourceIPAddress?: string;

  /**
   * The source IP address type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sourceIPAddressType?: EthernetAddressType;

  /**
   * Source network Id.
   */
  @visibility(Lifecycle.Read)
  sourceNetworkId?: string;

  /**
   * The target IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetIPAddress?: string;

  /**
   * The target IP address type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetIPAddressType?: EthernetAddressType;

  /**
   * Target subnet name.
   */
  targetSubnetName?: string;

  /**
   * Source network Id.
   */
  testNetworkId?: string;

  /**
   * Test subnet name.
   */
  testSubnetName?: string;

  /**
   * The test IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  testIPAddress?: string;

  /**
   * The test IP address type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  testIPAddressType?: EthernetAddressType;

  /**
   * Target NIC name.
   */
  targetNicName?: string;

  /**
   * A value indicating whether this NIC is selected for migration.
   */
  isSelectedForMigration?: string;
}

/**
 * VMwareCbt NIC input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtNicInput {
  /**
   * The NIC Id.
   */
  nicId: string;

  /**
   * A value indicating whether this is the primary NIC.
   */
  isPrimaryNic: string;

  /**
   * Target subnet name.
   */
  targetSubnetName?: string;

  /**
   * The static IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetStaticIPAddress?: string;

  /**
   * A value indicating whether this NIC is selected for migration.
   */
  isSelectedForMigration?: string;

  /**
   * Target NIC name.
   */
  targetNicName?: string;

  /**
   * The test subnet name.
   */
  testSubnetName?: string;

  /**
   * The test static IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  testStaticIPAddress?: string;
}

/**
 * VMware Cbt policy creation input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtPolicyCreationInput extends PolicyProviderSpecificInput {
  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistoryInMinutes?: int32;

  /**
   * The crash consistent snapshot frequency (in minutes).
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * The app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMware Cbt specific policy details.
 */
model VmwareCbtPolicyDetails extends PolicyProviderSpecificDetails {
  /**
   * The duration in minutes until which the recovery points need to be stored.
   */
  recoveryPointHistoryInMinutes?: int32;

  /**
   * The app consistent snapshot frequency in minutes.
   */
  appConsistentFrequencyInMinutes?: int32;

  /**
   * The crash consistent snapshot frequency in minutes.
   */
  crashConsistentFrequencyInMinutes?: int32;

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt provider specific container mapping details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtProtectionContainerMappingDetails
  extends ProtectionContainerMappingProviderSpecificDetails {
  /**
   * The target key vault ARM Id.
   */
  @visibility(Lifecycle.Read)
  keyVaultId?: string;

  /**
   * The target key vault URI.
   */
  @visibility(Lifecycle.Read)
  keyVaultUri?: string;

  /**
   * The storage account ARM Id.
   */
  @visibility(Lifecycle.Read)
  storageAccountId?: string;

  /**
   * The secret name of the storage account.
   */
  @visibility(Lifecycle.Read)
  storageAccountSasSecretName?: string;

  /**
   * The secret name of the service bus connection string.
   */
  @visibility(Lifecycle.Read)
  serviceBusConnectionStringSecretName?: string;

  /**
   * The target location.
   */
  @visibility(Lifecycle.Read)
  targetLocation?: string;

  /**
   * The role size to NIC count map.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  roleSizeToNicCountMap?: Record<int32>;

  /**
   * The SKUs to be excluded.
   */
  excludedSkus?: string[];

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt specific resume replication input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtResumeReplicationInput
  extends ResumeReplicationProviderSpecificInput {
  /**
   * A value indicating whether Migration resources to be deleted.
   */
  deleteMigrationResources?: string;

  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt specific resync input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtResyncInput extends ResyncProviderSpecificInput {
  /**
   * A value indicating whether CBT is to be reset.
   */
  skipCbtReset: string;

  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt specific test migrate input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtTestMigrateInput extends TestMigrateProviderSpecificInput {
  /**
   * The recovery point Id.
   */
  recoveryPointId: string;

  /**
   * The test network Id.
   */
  networkId: string;

  /**
   * The list of NIC details.
   */
  @identifiers(#[])
  vmNics?: VMwareCbtNicInput[];

  /**
   * A value indicating the inplace OS Upgrade version.
   */
  osUpgradeVersion?: string;

  /**
   * The managed run command script input.
   */
  @identifiers(#["stepName"])
  postMigrationSteps?: ManagedRunCommandScriptInput[];

  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * VMwareCbt disk input for update.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtUpdateDiskInput {
  /**
   * The disk Id.
   */
  diskId: string;

  /**
   * The target disk name.
   */
  targetDiskName?: string;

  /**
   * A value indicating whether the disk is the OS disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isOSDisk?: string;

  /**
   * The number of IOPS allowed for Premium V2 and Ultra disks.
   */
  iops?: int64;

  /**
   * The total throughput in Mbps for Premium V2 and Ultra disks.
   */
  throughputInMbps?: int64;

  /**
   * The target disk size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeInGB?: int64;
}

/**
 * VMwareCbt specific update migration item input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareCbtUpdateMigrationItemInput
  extends UpdateMigrationItemProviderSpecificInput {
  /**
   * The target VM name.
   */
  targetVmName?: string;

  /**
   * The target VM size.
   */
  targetVmSize?: string;

  /**
   * The target resource group ARM Id.
   */
  targetResourceGroupId?: string;

  /**
   * The target availability set ARM Id.
   */
  targetAvailabilitySetId?: string;

  /**
   * The target availability zone.
   */
  targetAvailabilityZone?: string;

  /**
   * The target proximity placement group ARM Id.
   */
  targetProximityPlacementGroupId?: string;

  /**
   * The target boot diagnostics storage account ARM Id.
   */
  targetBootDiagnosticsStorageAccountId?: string;

  /**
   * The target network ARM Id.
   */
  targetNetworkId?: string;

  /**
   * The test network ARM Id.
   */
  testNetworkId?: string;

  /**
   * The list of NIC details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmNics?: VMwareCbtNicInput[];

  /**
   * The list of disk update properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmDisks?: VMwareCbtUpdateDiskInput[];

  /**
   * The license type.
   */
  licenseType?: LicenseType;

  /**
   * The SQL Server license type.
   */
  sqlServerLicenseType?: SqlServerLicenseType;

  /**
   * The license type for Linux VM's.
   */
  linuxLicenseType?: LinuxLicenseType;

  /**
   * The OS name selected by user.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userSelectedOSName?: string;

  /**
   * A value indicating whether auto resync is to be done.
   */
  performAutoResync?: string;

  /**
   * The target VM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetVmTags?: Record<string>;

  /**
   * The tags for the target disks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetDiskTags?: Record<string>;

  /**
   * The tags for the target NICs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetNicTags?: Record<string>;

  /**
   * The target capacity reservation group ARM Id.
   */
  targetCapacityReservationGroupId?: string;

  /**
   * The class type.
   */
  instanceType: "VMwareCbt";
}

/**
 * Store the fabric details specific to the VMware fabric.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareDetails extends FabricSpecificDetails {
  /**
   * The list of Process Servers associated with the fabric.
   */
  processServers?: ProcessServer[];

  /**
   * The list of Master Target servers associated with the fabric.
   */
  masterTargetServers?: MasterTargetServer[];

  /**
   * The list of run as accounts created on the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  runAsAccounts?: RunAsAccount[];

  /**
   * The number of replication pairs configured in this CS.
   */
  replicationPairCount?: string;

  /**
   * The number of process servers.
   */
  processServerCount?: string;

  /**
   * The number of source and target servers configured to talk to this CS.
   */
  agentCount?: string;

  /**
   * The number of protected servers.
   */
  protectedServers?: string;

  /**
   * The percentage of the system load.
   */
  systemLoad?: string;

  /**
   * The system load status.
   */
  systemLoadStatus?: string;

  /**
   * The percentage of the CPU load.
   */
  cpuLoad?: string;

  /**
   * The CPU load status.
   */
  cpuLoadStatus?: string;

  /**
   * The total memory.
   */
  totalMemoryInBytes?: int64;

  /**
   * The available memory.
   */
  availableMemoryInBytes?: int64;

  /**
   * The memory usage status.
   */
  memoryUsageStatus?: string;

  /**
   * The total space.
   */
  totalSpaceInBytes?: int64;

  /**
   * The available space.
   */
  availableSpaceInBytes?: int64;

  /**
   * The space usage status.
   */
  spaceUsageStatus?: string;

  /**
   * The web load.
   */
  webLoad?: string;

  /**
   * The web load status.
   */
  webLoadStatus?: string;

  /**
   * The database server load.
   */
  databaseServerLoad?: string;

  /**
   * The database server load status.
   */
  databaseServerLoadStatus?: string;

  /**
   * The CS service status.
   */
  csServiceStatus?: string;

  /**
   * The IP address.
   */
  ipAddress?: string;

  /**
   * The agent Version.
   */
  agentVersion?: string;

  /**
   * The host name.
   */
  hostName?: string;

  /**
   * The last heartbeat received from CS server.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * Version status.
   */
  versionStatus?: string;

  /**
   * CS SSL cert expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sslCertExpiryDate?: utcDateTime;

  /**
   * CS SSL cert expiry date.
   */
  sslCertExpiryRemainingDays?: int32;

  /**
   * PS template version.
   */
  psTemplateVersion?: string;

  /**
   * Agent expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentExpiryDate?: utcDateTime;

  /**
   * The agent version details.
   */
  agentVersionDetails?: VersionDetails;

  /**
   * The switch provider blocking error information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  switchProviderBlockingErrorDetails?: InMageFabricSwitchProviderBlockingErrorDetails[];

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "VMware";
}

/**
 * VMwareV2 fabric provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareV2FabricCreationInput extends FabricSpecificCreationInput {
  /**
   * The ARM Id of the VMware site.
   */
  vmwareSiteId?: string;

  /**
   * The ARM Id of the physical site.
   */
  physicalSiteId?: string;

  /**
   * The ARM Id of the migration solution.
   */
  migrationSolutionId: string;

  /**
   * Gets the class type.
   */
  instanceType: "VMwareV2";
}

/**
 * VMwareV2 fabric specific details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareV2FabricSpecificDetails extends FabricSpecificDetails {
  /**
   * The ARM Id of the VMware site.
   */
  @visibility(Lifecycle.Read)
  vmwareSiteId?: string;

  /**
   * The ARM Id of the physical site.
   */
  @visibility(Lifecycle.Read)
  physicalSiteId?: string;

  /**
   * The Migration solution ARM Id.
   */
  @visibility(Lifecycle.Read)
  migrationSolutionId?: string;

  /**
   * The service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * The service resource Id.
   */
  @visibility(Lifecycle.Read)
  serviceResourceId?: string;

  /**
   * The service container Id.
   */
  @visibility(Lifecycle.Read)
  serviceContainerId?: string;

  /**
   * The list of process servers.
   */
  @visibility(Lifecycle.Read)
  processServers?: ProcessServerDetails[];

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "VMwareV2";
}

/**
 * VMware provider specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMwareVirtualMachineDetails extends ConfigurationSettings {
  /**
   * The ID generated by the InMage agent after it gets installed on guest. This is the ID to be used during InMage CreateProtection.
   */
  agentGeneratedId?: string;

  /**
   * The value indicating if InMage scout agent is installed on guest.
   */
  agentInstalled?: string;

  /**
   * The OsType installed on VM.
   */
  osType?: string;

  /**
   * The agent version.
   */
  agentVersion?: string;

  /**
   * The IP address.
   */
  ipAddress?: string;

  /**
   * The value indicating whether VM is powered on.
   */
  poweredOn?: string;

  /**
   * The VCenter infrastructure Id.
   */
  vCenterInfrastructureId?: string;

  /**
   * A value indicating the discovery type of the machine. Value can be vCenter or physical.
   */
  discoveryType?: string;

  /**
   * The disk details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskDetails?: InMageDiskDetails[];

  /**
   * The validation errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationErrors?: HealthError[];

  /**
   * Gets the class type. Overridden in derived classes.
   */
  instanceType: "VMwareVirtualMachine";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Vault is Azure.ResourceManager.TrackedResource<{}, true> {
  ...ResourceNameParameter<
    Resource = Vault,
    KeyName = "resourceName",
    SegmentName = "vaults",
    NamePattern = ""
  >;
}
