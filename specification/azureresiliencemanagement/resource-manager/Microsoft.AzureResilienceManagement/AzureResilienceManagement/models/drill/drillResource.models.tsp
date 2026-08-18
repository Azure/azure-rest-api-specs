import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./enums.tsp";
import "./common.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureResilienceManagement;

/**
 * Resource definition for the Drill resource Object.
 */
@parentResource(Drill)
@doc("Drill Resource")
model DrillResource is ProxyResource<DrillResourceProperties> {
  @doc("The name of the DrillResource (GUID).")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("drillResourceName")
  @segment("drillResources")
  @path
  name: string;
}

@doc("Properties of the Resiliency Drill Resource")
model DrillResourceProperties {
  @doc("ARM Id of the underlying resource.")
  resourceId: armResourceIdentifier<[]>;

  @doc("Type of the Drill resource.")
  resourceType: string;

  @doc("Active location and zones of the Azure resource.")
  @added(Versions.v2026_03_01_preview)
  @visibility(Lifecycle.Read)
  activeLocations?: string[];

  @doc("List of recovery locations and zones of the Azure resource.")
  @added(Versions.v2026_03_01_preview)
  @visibility(Lifecycle.Read)
  recoveryLocations?: string[];

  @doc("Active Resource location and physical zones of Azure Resource.")
  @added(Versions.v2026_03_01_preview)
  @visibility(Lifecycle.Read)
  activePhysicalZones?: string[];

  @doc("Recovery Resource location and physical zones of HA Azure Resource.")
  @added(Versions.v2026_03_01_preview)
  @visibility(Lifecycle.Read)
  recoveryPhysicalZones?: string[];

  @doc("Inclusion State of the Drill resource in Drill")
  inclusionState?: DrillResourceInclusionState;

  @doc("Inclusion State of the Drill resource in Recovery Plan")
  @visibility(Lifecycle.Read)
  recoveryPlanInclusionState?: ResourceInclusionState;

  @doc("Exclusion reason of the Drill resource in Recovery Plan")
  @visibility(Lifecycle.Read)
  recoveryPlanExclusionReason?: RecoveryPlanExclusionReason;

  @doc("Protection Solution Type of the Drill resource")
  @visibility(Lifecycle.Read)
  resourceProtectionSolutionType?: ResourceProtectionSolutionType;

  @doc("Readiness State of the Drill resource")
  @visibility(Lifecycle.Read)
  readinessState?: DrillResourceReadinessState;

  @doc("Fault State of the Drill resource")
  @visibility(Lifecycle.Read)
  faultState?: DrillResourceFaultState;

  @doc("Fault Properties")
  @visibility(Lifecycle.Read)
  faultProperties?: FaultProperties;

  @doc("ForceInclusion status for this resource. Has the customer forceIncluded it?")
  @visibility(Lifecycle.Read)
  forceInclusionState?: ForceInclusionAndUpdate;

  @doc("HA status of the Drill resource")
  @visibility(Lifecycle.Read)
  haStatus?: HAStatus;

  @doc("Attention reason if the Status is 'NeedsAttention'.")
  @visibility(Lifecycle.Read)
  attentionReason?: DrillResourceAttentionReason;

  @doc("Recommendation Type Id for the recommendation.")
  @visibility(Lifecycle.Read)
  advisorRecommendationTypeId?: string;

  @doc("Associated Advisor Recommendation link, if HA is not enabled on this resource.")
  @visibility(Lifecycle.Read)
  advisorHaRecommendationId?: armResourceIdentifier<[
    {
      type: "Microsoft.Advisor/recommendations";
    }
  ]>;

  @doc("Last Target and Capability assignment error, if any.")
  @removed(Versions.v2026_04_01_preview)
  @visibility(Lifecycle.Read)
  targetAndCapabilityAssignmentError?: ErrorDetails;

  @doc("Last Target Resource RBAC assignment error, if any.")
  @added(Versions.v2026_03_01_preview)
  @removed(Versions.v2026_04_01_preview)
  @visibility(Lifecycle.Read)
  targetResourceAssignmentError?: ErrorDetails;

  @doc("Last RBAC assignment error, if any.")
  @visibility(Lifecycle.Read)
  rbacAssignmentError?: ErrorDetails;

  @doc("Monitoring RBAC assignment error, if any.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_03_01_preview)
  monitoringRbacAssignmentError?: ErrorDetails;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Reason why the Drill resource is in NeedsAttention state.")
model DrillResourceAttentionReason {
  @doc("Experiment MSI does not have the desired RBAC on the resource.")
  @removed(Versions.v2026_04_01_preview)
  faultRbacOnTarget?: RBACState;

  @doc("Chaos Resource MSI does not have the desired RBAC on the resource.")
  @added(Versions.v2026_03_01_preview)
  faultRbacOnTargetResource?: RBACState;

  @doc("RBAC required by AutomationAccount for runbook MSI not setup on the target resources.")
  runbookFaultRbacOnTargets?: RBACState;

  @doc("RBAC required by Drill MSI on the target resource for monitoring.")
  @added(Versions.v2026_03_01_preview)
  monitoringRbacOnTargets?: RBACState;

  @doc("Target extension resource is missing on the resource.")
  @removed(Versions.v2026_04_01_preview)
  target?: ExtensionObjectState;

  @doc("Drill Resource State (wrt SG and RO).")
  resourceState?: DrillResourceState[];
}
