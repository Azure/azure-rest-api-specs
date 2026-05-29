import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureResilienceManagement;

/**
 * Enum of the execution state.
 */
@doc("Drill Execution State")
union ExecutionState {
  string,

  @doc("Drill is not running currently.")
  NotRunning: "NotRunning",

  @doc("Drill is running currently.")
  Running: "Running",

  @doc("Drill is paused, waiting for manual resume.")
  Paused: "Paused",
}

/**
 * Enum of the readiness state.
 */
@doc("Drill Execution Readiness State")
union ExecutionReadinessState {
  string,

  @doc("Drill is ready to run.")
  Ready: "Ready",

  @doc("Drill is not ready to run. Details captured in AttentionReason field.")
  NeedsAttention: "NeedsAttention",
}

/**
 * Enum for Drill.Start mode
 */
@doc("Start mode of Drill.")
union DrillMode {
  string,

  @doc("Failover mode.")
  Failover: "Failover",

  @doc("TestFailover mode.")
  @removed(Versions.v2026_04_01_preview)
  TestFailover: "TestFailover",
}

/**
 * Enum for RBAC setup
 */
@doc("RBAC setup mode.")
union RBACSetupMode {
  string,

  @doc("Automated-CustomRole mode.")
  AutomatedCustomRole: "AutomatedCustomRole",

  @doc("Automated-BuiltinRoles mode.")
  AutomatedBuiltinRoles: "AutomatedBuiltinRoles",

  @doc("Manual mode.")
  Manual: "Manual",
}

/**
 * Enum for Attestation Status
 */
@doc("Drill Attestation status on terminating.")
union DrillAttestation {
  string,

  @doc("Drill Attestation success.")
  AttestedSuccess: "Success",

  @doc("Drill Attestation failure.")
  AttestedFailed: "Failed",
}

@doc("HA Status")
union HAStatus {
  string,

  @doc("HA enabled.")
  Enabled: "Enabled",

  @doc("HA not enabled.")
  NotEnabled: "NotEnabled",
}

/**
 * Enum for Inclusion State
 */
@doc("Drill Resource Inclusion State")
union DrillResourceInclusionState {
  string,

  @doc("Resource excluded from Drill.")
  Excluded: "Excluded",

  @doc("Resource included in Drill.")
  Included: "Included",
}

/**
 * Enum for Readiness State
 */
@doc("Drill Resource Readiness State")
union DrillResourceReadinessState {
  string,

  @doc("Resource ready.")
  Ready: "Ready",

  @doc("Resource needs attention.")
  NeedsAttention: "NeedsAttention",
}

/**
 * Enum for Fault State
 */
@doc("Drill Resource Fault State")
union DrillResourceFaultState {
  string,

  @doc("Native fault available.")
  SystemNative: "SystemNative",

  @doc("Custom script based fault associated with resource.")
  CustomScript: "CustomScript",

  @doc("No fault configured for this resource.")
  NotDefined: "NotDefined",
}

/**
 * Enum for Resource State (wrt SG and RO)
 */
@doc("Drill Resource State (wrt SG and RO).")
union DrillResourceState {
  string,

  @doc("Resource is in SG but not part of the Drill")
  InServiceGroupNotInDrill: "InServiceGroupNotInDrill",

  @doc("Resource is in Drill but not part of the SG")
  InDrillNotInServiceGroup: "InDrillNotInServiceGroup",

  @doc("Resource is in RecoveryPlan but not part of the Drill")
  InRecoveryPlanNotInDrill: "InRecoveryPlanNotInDrill",

  @doc("Resource is in Drill but not part of the RecoveryPlan")
  InDrillNotInRecoveryPlan: "InDrillNotInRecoveryPlan",

  @doc("Resource is not in a state where it can be faulted.")
  ResourceStateIncompatibleWithFault: "ResourceStateIncompatibleWithFault",
}

/**
 * Enum for AttentionReason - RBAC state on a resource
 */
@doc("Enum for AttentionReason - RBAC state on a resource.")
union RBACState {
  string,

  @doc("RBAC set.")
  Set: "Set",

  @doc("RBAC not set.")
  NotSet: "NotSet",
}

/**
 * Enum for AttentionReason - Extension Object State
 */
@doc("Enum for AttentionReason - Extension Object State.")
union ExtensionObjectState {
  string,

  @doc("Extension object exists.")
  Exists: "Exists",

  @doc("Extension object not exists.")
  NotExists: "NotExists",
}

/**
 * Enum for AttentionReason - Resource state sync between two objects
 */
@doc("Enum for AttentionReason - Resource state sync between two objects.")
union RelativeResourceCompositionState {
  string,

  @doc("Resources in sync.")
  InSync: "InSync",

  @doc("Resources out of sync.")
  OutOfSync: "OutOfSync",
}

/**
 * Enum for Initial config of Drill object
 */
@doc("Enum for Initial config of Drill object.")
union InitialConfig {
  string,

  @doc("Initial config pending.")
  Pending: "Pending",

  @doc("Initial config complete.")
  Complete: "Complete",
}

/**
 * Enum for Drill type object hierarchy
 */
@doc("Enum for Drill type object hierarchy.")
union DrillType {
  string,

  @doc("Zonal Drill.")
  Zonal: "Zonal",

  @doc("Regional Drill.")
  Regional: "Regional",
}

/**
 * Enum for VM inclusion
 */
@doc("Enum for VM presence.")
union VMPresent {
  string,

  @doc("Atleast one VM Present.")
  Present: "Present",

  @doc("No VM present.")
  Absent: "Absent",
}

/**
 * Enum for Drill Run Subtasks.
 */
@doc("Enum for Drill Run Subtasks.")
union DrillRunSubtasks {
  string,

  @doc("FaultInjection Subtasks.")
  FaultInjection: "FaultInjection",

  @doc("Failover Subtasks.")
  Failover: "Failover",

  @doc("TestFailover Subtasks.")
  @removed(Versions.v2026_04_01_preview)
  TestFailover: "TestFailover",

  @doc("TestFailoverCleanup Subtasks.")
  @removed(Versions.v2026_04_01_preview)
  TestFailoverCleanup: "TestFailoverCleanup",

  @doc("Reprotect Subtasks.")
  Reprotect: "Reprotect",

  @doc("FailoverReverse Subtasks.")
  FailoverReverse: "FailoverReverse",

  @doc("ReprotectReverse Subtasks.")
  ReprotectReverse: "ReprotectReverse",
}

/**
 * Enum for DrillRun operation actions.
 */
@doc("Enum for DrillRun operation actions.")
union DrillRunOperationVerbs {
  string,

  @doc("Start Action.")
  Start: "Start",

  @doc("Retry Action.")
  Retry: "Retry",

  @doc("MarkAsComplete Action.")
  MarkAsComplete: "MarkAsComplete",

  @doc("Cancel Action.")
  Cancel: "Cancel",
}

/**
 * Enum for Enum for RecoveryPlan Exclusion reason.
 */
@doc("Enum for RecoveryPlan Exclusion reason.")
union RecoveryPlanExclusionReason {
  string,

  @doc("Excluded From RecoveryPlan by user.")
  ExcludedFromRecoveryPlan: "ExcludedFromRecoveryPlan",

  @doc("Protection not configured.")
  ProtectionStatus: "ProtectionStatus",
}

/**
 * Enum for DrillRun Tasks.
 */
@doc("Enum for DrillRun Tasks.")
union DrillRunTasks {
  string,

  @doc("Failover task.")
  Failover: "Failover",

  @doc("TestFailover tasks.")
  @removed(Versions.v2026_04_01_preview)
  TestFailover: "TestFailover",

  @doc("TestFailoverCleanup tasks.")
  @removed(Versions.v2026_04_01_preview)
  TestFailoverCleanup: "TestFailoverCleanup",

  @doc("Reprotect task.")
  Reprotect: "Reprotect",

  @doc("FailoverReverse task.")
  FailoverReverse: "FailoverReverse",

  @doc("ReprotectReverse task.")
  ReprotectReverse: "ReprotectReverse",
}

/**
 * Enum for Health Status.
 */
@doc("Enum for Health Status.")
union HealthStatus {
  string,

  @doc("Healthy status.")
  Healthy: "Healthy",

  @doc("Degraded status.")
  Degraded: "Degraded",

  @doc("Unhealthy Status.")
  Unhealthy: "Unhealthy",
}

/**
 * Enum for ForceInclusionAndUpdate
 */
@doc("Enum for ForceInclusionAndUpdate")
union ForceInclusionAndUpdate {
  string,

  @doc("Enable ForceInclusionAndUpdate.")
  Enable: "Enable",

  @doc("Disable ForceInclusionAndUpdate.")
  Disable: "Disable",
}

/**
 * Enum for AutoFailover
 */
@doc("Enum for AutoFailover")
union AutoFailover {
  string,

  @doc("Enable AutoFailover.")
  Enable: "Enable",

  @doc("Disable AutoFailover.")
  Disable: "Disable",
}

@doc("A state type that indicates qualification of a resource for an operation.")
@added(Versions.v2026_03_01_preview)
union DrillResourceNonQualificationReasons {
  string,

  @doc("Resource is not included in the recovery plan.")
  @added(Versions.v2026_03_01_preview)
  ResourceNotIncludedInRecoveryPlan: "ResourceNotIncludedInRecoveryPlan",

  @doc("Resource is not included in the drill.")
  @added(Versions.v2026_03_01_preview)
  ResourceNotIncludedInDrill: "ResourceNotIncludedInDrill",

  @doc("Resource location does not match the source location.")
  @added(Versions.v2026_03_01_preview)
  ResourceLocationNotMatchingWithSourceLocation: "ResourceLocationNotMatchingWithSourceLocation",

  @doc("Resource zone does not match the source zone.")
  @added(Versions.v2026_03_01_preview)
  ResourceZoneNotMatchingWithSourceZone: "ResourceZoneNotMatchingWithSourceZone",
}

@doc("A state type that indicates qualification of a resource for an operation.")
@added(Versions.v2026_03_01_preview)
union ResourceTypeCategories {
  string,

  @doc("Indicates that alteast one Azure Site Recovery VMs are present.")
  @added(Versions.v2026_03_01_preview)
  AzureSiteRecoveryVMsPresent: "AzureSiteRecoveryVMsPresent",
}
