import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("A service-level resource associated with a goal assignment.")
model ServiceLevelResource {
  @doc("The ARM resource ID of the service-level indicator resource.")
  serviceLevelIndicatorResourceId: armResourceIdentifier;

  @doc("The ARM resource ID of the service-level objective resource.")
  @madeOptional(Versions.v2026_06_01_preview)
  @removed(Versions.v2026_09_30_preview)
  serviceLevelObjectiveResourceId?: armResourceIdentifier;
}

@added(Versions.v2026_10_31_preview)
@doc("Recovery objectives targeted by a goal assignment for regional resiliency.")
model RegionalObjectives {
  @doc("Target regional recovery point objective. eg, PT15M for 15 minutes.")
  targetRecoveryPointObjective: IsoDuration;

  @doc("Target regional recovery time objective. eg, PT1H for 1 hour.")
  targetRecoveryTimeObjective: IsoDuration;
}

// Define the main model
@doc("Properties of a goal assignment.")
model GoalAssignmentProperties {
  @doc("Arm id of the goal template.")
  @madeOptional(Versions.v2026_06_01_preview)
  @removed(Versions.v2026_09_30_preview)
  goalTemplateId?: armResourceIdentifier;

  @doc("The type of goal assignment.")
  @madeOptional(Versions.v2026_06_01_preview)
  @removed(Versions.v2026_09_30_preview)
  goalAssignmentType?: GoalAssignmentType;

  @doc("Whether zonal resiliency is required for this goal assignment.")
  @added(Versions.v2026_06_01_preview)
  @madeRequired(Versions.v2026_09_30_preview)
  requireZonalResiliency: boolean;

  @doc("Whether regional resiliency is required for this goal assignment.")
  @added(Versions.v2026_10_31_preview)
  requireRegionalResiliency?: boolean;

  @doc("Recovery objectives targeted for regional resiliency.")
  @added(Versions.v2026_10_31_preview)
  regionalObjectives?: RegionalObjectives;

  @doc("List of service level resources.")
  @identifiers(#[])
  serviceLevelResources?: ServiceLevelResource[];

  @doc("The provisioning state of the goal assignment.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Details of any errors encountered during the operation.")
  errorDetails?: CommonTypes.ErrorDetail;
}

@tenantResource
@doc("A goal assignment resource in the Azure Resilience Management provider.")
model GoalAssignment is ProxyResource<GoalAssignmentProperties> {
  @doc("The name of the goal assignment.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("goalAssignmentName")
  @segment("goalAssignments")
  @path
  name: string;

  // Adding suppressions because in-build ManagedServiceIdentityProperty has used Record which need suppression.
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Removing identity in v2026, keeping for backward compat in v2025"
  @doc("The managed service identities assigned to this resource.")
  @removed(Versions.v2026_03_01_preview)
  identity?: CommonTypes.ManagedServiceIdentity;
}
