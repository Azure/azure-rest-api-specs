using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20260315)
@doc("The properties of the sovereign view resource type.")
model SovereignViewResourceProperties {
  @doc("The scope to apply for configuration.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scope: SovereignViewConfigureScope;

  @doc("The policy initiatives to assign.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @identifiers(#["policyInitiativeId"])
  policyInitiatives: SovereignViewPolicyInitiativeAssignment[];

  @visibility(Lifecycle.Read)
  @doc("The status of a user-initiated, control-plane operation on the sovereign view resource type.")
  provisioningState?: provisioningState;
}

@added(Versions.Preview20260315)
@doc("The scope for the sovereign view configure action.")
model SovereignViewConfigureScope {
  @doc("The resource identifiers of the management groups in scope.")
  managementGroups: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>[];

  @doc("The subscription ids in scope.")
  subscriptions: uuid[];
}

@added(Versions.Preview20260315)
@doc("The policy initiative assignment for the sovereign view configure action.")
model SovereignViewPolicyInitiativeAssignment {
  @doc("The fully qualified id of the policy initiative.")
  policyInitiativeId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policySetDefinitions";
    }
  ]>;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Parameters vary based on the selected policy initiatives."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Parameters vary based on the selected policy initiatives."
  @doc("The parameters for the assignment of policy initiatives.")
  assignmentParameters: Record<unknown>;
}

@added(Versions.Preview20260315)
@doc("The request for the sovereign view compliance summary action.")
model SovereignViewComplianceSummaryRequest {
  @doc("The dimension to summarize compliance for.")
  dimension: string;
}

@added(Versions.Preview20260315)
@doc("The response for the sovereign view compliance summary action.")
model SovereignViewComplianceSummaryResponse {
  @doc("The resource identifier of the sovereign view.")
  resourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/sovereignViews";
    }
  ]>;

  @doc("The dimension summarized for compliance.")
  dimension: string;

  @doc("The total number of resources evaluated.")
  totalResources: int32;

  @doc("The number of compliant resources.")
  compliantCount: int32;

  @doc("The number of non-compliant resources.")
  nonCompliantCount: int32;

  @doc("The time when compliance was last evaluated, in RFC3339 format.")
  lastEvaluated: utcDateTime;
}

@added(Versions.Preview20260315)
@doc("The request for the sovereign view compliance details action.")
model SovereignViewComplianceDetailsRequest {
  @doc("The maximum number of resources to return.")
  top: int32;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Pagination tokens are not sensitive in this API."
  @doc("The skip token for pagination.")
  skipToken?: string;

  @doc("The dimension to filter compliance details by.")
  dimension: string;
}

@added(Versions.Preview20260315)
@doc("A compliance detail item for a resource.")
model SovereignViewComplianceDetail {
  @doc("The resource identifier.")
  resourceId: armResourceIdentifier<[]>;

  @doc("The resource type.")
  resourceType: string;

  @doc("The compliance dimension.")
  dimension: string;

  @doc("The compliance state.")
  state: string;

  @doc("The time when the resource was evaluated.")
  evaluatedAt: utcDateTime;

  @doc("The reason for the compliance state.")
  reason: string;
}

@added(Versions.Preview20260315)
@doc("The response for the sovereign view compliance details action.")
model SovereignViewComplianceDetailsResponse {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Pagination tokens are not sensitive in this API."
  @doc("The skip token for pagination.")
  skipToken?: string;

  @doc("The list of compliance detail resources.")
  @identifiers(#["resourceId", "dimension"])
  resources: SovereignViewComplianceDetail[];
}
