using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20260315)
@doc("The properties of the sovereign view resource type.")
model SovereignViewResourceProperties {
  @doc("The dimensions enabled for the sovereign view.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  enabledDimensions: string[];

  @doc("The scope to apply for configuration.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scope: SovereignViewConfigureScope;

  @doc("The policy initiatives selected for the sovereign view.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @identifiers(#["policyInitiativeId"])
  policyInitiatives: SovereignViewPolicyInitiativeDetail[];

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
  subscriptions: string[];
}

@added(Versions.Preview20260315)
@doc("The policy initiative details for the sovereign view.")
model SovereignViewPolicyInitiativeDetail {
  @doc("The fully qualified id of the policy initiative.")
  policyInitiativeId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policySetDefinitions";
    }
  ]>;

  @doc("The policy assignment ids created for the policy initiative.")
  policyAssignmentIds?: string[];

  @doc("The version of the policy initiative.")
  policyVersion: string;

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

  @doc("The time when compliance was last evaluated, in RFC3339 format.")
  lastEvaluated: utcDateTime;

  @doc("The overall summary of compliance across all resources in scope.")
  overallSummary: SovereignViewComplianceOverallSummary;

  @doc("The list of compliance summaries for each dimension (policy initiative) in scope.")
  @identifiers(#["policyInitiativeId"])
  dimensionSummaries: SovereignViewComplianceDimensionSummary[];
}

@added(Versions.Preview20260315)
@doc("The response for the sovereign view compliance summary action.")
model SovereignViewComplianceOverallSummary {
  @doc("Total number of management groups for the sovereign view.")
  totalManagementGroups: int32;

  @doc("Total number of subscriptions for the sovereign view.")
  totalSubscriptions: int32;

  @doc("Total number of resource groups for the sovereign view.")
  totalResourceGroups: int32;

  @doc("Total number of resources for the sovereign view.")
  totalResources: int32;

  @doc("Number of compliant resources for the sovereign view.")
  compliantCount: int32;

  @doc("Number of non-compliant resources for the sovereign view.")
  nonCompliantCount: int32;
}

@added(Versions.Preview20260315)
@doc("The compliance summary for a specific dimension (policy inititative) in the sovereign view compliance summary action.")
model SovereignViewComplianceDimensionSummary {
  @doc("The name of the policy initiative associated with this dimension.")
  policyInitiativeId: string;

  @doc("Total number of resources for the sovereign view.")
  totalResources: int32;

  @doc("Number of compliant resources for the sovereign view.")
  compliantCount: int32;

  @doc("Number of non-compliant resources for the sovereign view.")
  nonCompliantCount: int32;
}

@added(Versions.Preview20260315)
@doc("The request for the sovereign view compliance details action.")
model SovereignViewComplianceDetailsRequest {
  @doc("The maximum number of resources to return.")
  top: int32;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Pagination tokens are not sensitive in this API."
  @doc("The skip token for pagination.")
  skipToken?: string;
}

@added(Versions.Preview20260315)
@doc("The response for the sovereign view compliance details action.")
model SovereignViewComplianceDetailsResponse {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Pagination tokens are not sensitive in this API."
  @doc("The skip token for pagination.")
  nextToken?: string;

  @doc("The time when compliance was last evaluated, in RFC3339 format.")
  lastEvaluated: utcDateTime;

  @doc("The list of compliance detail resources.")
  @identifiers(#["resourceId"])
  resources: SovereignViewComplianceDetailResource[];
}

@added(Versions.Preview20260315)
@doc("A compliance detail item for a resource.")
model SovereignViewComplianceDetailResource {
  @doc("The resource identifier.")
  resourceId: armResourceIdentifier<[]>;

  @doc("The subscription id of the resource.")
  subscription: string;

  @doc("The resource group name of the resource.")
  resourceGroup: string;

  @doc("The name of the resource.")
  resourceName: string;

  @doc("The location of the resource.")
  location: string;

  @doc("The compliance details for the resource.")
  @identifiers(#["policyInitiativeId"])
  complianceDetails: SovereignViewComplianceDetail[];
}

@added(Versions.Preview20260315)
@doc("A compliance detail item for a resource in the sovereign view compliance details action.")
model SovereignViewComplianceDetail {
  @doc("The fully qualified id of the policy initiative.")
  policyInitiativeId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policySetDefinitions";
    }
  ]>;

  @doc("The compliance state of the resource for the policy initiative.")
  isCompliant: boolean;

  @doc("The reasons for the compliance state.")
  reasons: string[];
}
