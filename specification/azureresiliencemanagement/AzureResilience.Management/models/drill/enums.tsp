import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
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
@doc("Drill Readiness State")
union ReadinessState {
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
  InSGNotInDrill: "InSGNotInDrill",

  @doc("Resource is in Drill but not part of the SG")
  InDrillNotInSG: "InDrillNotInSG",

  @doc("Resource is in ROPlan but not part of the Drill")
  InRONotInDrill: "InRONotInDrill",

  @doc("Resource is in Drill but not part of the ROPlan")
  InDrillNotInRO: "InDrillNotInRO",

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
  TestFailover: "TestFailover",

  @doc("TestFailoverCleanup Subtasks.")
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
}

/**
 * Enum for Enum for RO Exclusion reason.
 */
@doc("Enum for RO Exclusion reason.")
union RoExclusionReason {
  string,

  @doc("Excluded From Ro by user.")
  ExcludedFromRo: "ExcludedFromRo",

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
  TestFailover: "TestFailover",

  @doc("TestFailoverCleanup tasks.")
  TestFailoverCleanup: "TestFailoverCleanup",

  @doc("Reprotect task.")
  Reprotect: "Reprotect",

  @doc("FailoverReverse task.")
  FailoverReverse: "FailoverReverse",

  @doc("ReprotectReverse task.")
  ReprotectReverse: "ReprotectReverse",
}
