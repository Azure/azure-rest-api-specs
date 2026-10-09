import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "./goalAssignment.tsp";
import "./enum.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

// Define the main model
@added(Versions.v2026_06_01_preview)
@doc("Resiliency posture for a goal resource.")
model ResiliencyProperties {
  @doc("Indicates whether the ARM resource is excluded from resiliency recommendations.")
  goalParticipation?: ExclusionState;

  @doc("Indicates whether the ARM resource's resiliency posture is manually attested.")
  attestationStatus?: AttestationState;

  @doc("The reason the ARM resource is excluded from resiliency goals.")
  @visibility(Lifecycle.Read)
  exclusionReason?: ExclusionReason;

  @doc("User confirmations for resiliency solutions recommended for the ARM resource.")
  @identifiers(#["solutionDisplayName"])
  userConfirmation?: UserConfirmationItem[];
}

@doc("Properties of a goal resource.")
model GoalResourceProperties {
  @doc("The fully qualified ARM resource ID represented by this goal resource.")
  resourceArmId: armResourceIdentifier;

  @doc("Flag which depicts whether the Arm resource is excluded for high availability recommendation.")
  @madeOptional(Versions.v2026_06_01_preview)
  @removed(Versions.v2026_09_30_preview)
  highAvailabilityGoalParticipation?: ExclusionState;

  @doc("Flag which depicts whether the Arm resource is manually attested for high availability recommendation.")
  @madeOptional(Versions.v2026_06_01_preview)
  @removed(Versions.v2026_09_30_preview)
  highAvailabilityAttestationStatus?: AttestationState;

  @doc("The zonal resiliency posture for the ARM resource, including participation, attestation, exclusion reason, and user confirmations.")
  @added(Versions.v2026_06_01_preview)
  zonalResiliency?: ResiliencyProperties;

  @doc("The regional resiliency posture for the ARM resource, including participation, attestation, exclusion reason, and user confirmations.")
  @added(Versions.v2026_10_31_preview)
  regionalResiliency?: ResiliencyProperties;

  @doc("Flag which depicts whether the Arm resource is excluded for disaster recovery recommendation.")
  @removed(Versions.v2026_09_30_preview)
  disasterRecoveryGoalParticipation?: ExclusionState;

  @doc("Flag which depicts whether the Arm resource is manually attested for disaster recovery recommendation.")
  @removed(Versions.v2026_09_30_preview)
  disasterRecoveryAttestationStatus?: AttestationState;

  @doc("Reason for exclusion from high availability goals.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2026_09_30_preview)
  exclusionReasonForHighAvailabilityGoals?: ExclusionReason;

  @doc("Reason for exclusion from disaster recovery goals.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2026_09_30_preview)
  exclusionReasonForDisasterRecoveryGoals?: ExclusionReason;

  @added(Versions.v2026_03_01_preview)
  @removed(Versions.v2026_09_30_preview)
  @doc("List of user confirmations for high availability solutions.")
  @identifiers(#["solutionDisplayName"])
  userConfirmationForHighAvailability?: UserConfirmationItem[];

  @doc("List of service groups of which this resource is memberof.")
  @visibility(Lifecycle.Read)
  @identifiers(#["serviceGroupId"])
  @removed(Versions.v2026_09_30_preview)
  serviceGroupMemberships?: ServiceGroupMembership[];

  @doc("The provisioning state of the goal resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

// Define a request model which is array of UpdateGoalResource.
@doc("Request body for updating goal resources.")
model UpdateGoalResourceRequest {
  @doc("The goal resources to update.")
  resources: GoalResource[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Response from updating goal resources.")
model UpdateGoalResourceResponse {
  @doc("The updated goal resources.")
  resources: GoalResource[];
}

@parentResource(GoalAssignment)
@doc("A goal resource in the Azure Resilience Management provider.")
model GoalResource is ProxyResource<GoalResourceProperties> {
  @doc("The name of the goal resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("goalResourceName")
  @segment("goalResources")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Response model for refresh goal resources.")
model RefreshGoalResourcesResponse {
  @doc("Total count of resources under the goal assignment after refresh.")
  resourceCount?: int32;

  @doc("Time when the refresh operation was last performed.")
  lastRefreshTime?: utcDateTime;
}
