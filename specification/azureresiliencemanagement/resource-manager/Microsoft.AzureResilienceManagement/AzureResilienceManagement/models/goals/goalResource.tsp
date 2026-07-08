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
@doc("Definition of goal assignment property.")
model GoalResourceProperties {
  @doc("Arm Id of resource under the SG for which the extension resource is maintained.")
  resourceArmId: armResourceIdentifier;

  @doc("Flag which depicts whether the Arm resource is excluded for high availability recommendation.")
  highAvailabilityGoalParticipation: ExclusionState;

  @doc("Flag which depicts whether the Arm resource is manually attested for high availability recommendation.")
  highAvailabilityAttestationStatus: AttestationState;

  @doc("Flag which depicts whether the Arm resource is excluded for disaster recovery recommendation.")
  disasterRecoveryGoalParticipation?: ExclusionState;

  @doc("Flag which depicts whether the Arm resource is manually attested for disaster recovery recommendation.")
  disasterRecoveryAttestationStatus?: AttestationState;

  @doc("Reason for exclusion from high availability goals.")
  @visibility(Lifecycle.Read)
  exclusionReasonForHighAvailabilityGoals?: ExclusionReason;

  @doc("Reason for exclusion from disaster recovery goals.")
  @visibility(Lifecycle.Read)
  exclusionReasonForDisasterRecoveryGoals?: ExclusionReason;

  @added(Versions.v2026_03_01_preview)
  @doc("List of user confirmations for high availability solutions.")
  @identifiers(#["solutionDisplayName"])
  userConfirmationForHighAvailability?: UserConfirmationForHighAvailabilityItem[];

  @doc("List of service groups of which this resource is memberof.")
  @visibility(Lifecycle.Read)
  @identifiers(#["serviceGroupId"])
  serviceGroupMemberships?: ServiceGroupMembership[];

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

// Define a request model which is array of UpdateGoalResource.
@doc("Request model for update goal resource.")
model UpdateGoalResourceRequest {
  @doc("List of update goal resource.")
  resources: GoalResource[];
}

@doc("Response model for update goal resource.")
model UpdateGoalResourceResponse {
  @doc("List of update goal resource.")
  resources: GoalResource[];
}

@parentResource(GoalAssignment)
@doc("Goal Resource a AzureResilienceProviderHub resource")
model GoalResource is ProxyResource<GoalResourceProperties> {
  @doc("The name of the GoalAssignment")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("goalResourceName")
  @segment("goalResources")
  @path
  name: string;
}

@doc("Response model for refresh goal resources.")
model RefreshGoalResourcesResponse {
  @doc("Total count of resources under the goal assignment after refresh.")
  resourceCount?: int32;

  @doc("Time when the refresh operation was last performed.")
  lastRefreshTime?: utcDateTime;
}
