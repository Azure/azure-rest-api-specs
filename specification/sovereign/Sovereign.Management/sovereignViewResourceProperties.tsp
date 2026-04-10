using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20260315)
@doc("The properties of the sovereign view resource type.")
model SovereignViewResourceProperties {
  @doc("The scope to apply for configuration.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scope: SovereignViewScope;

  @doc("The policy initiatives selected for the sovereign view.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @identifiers(#["policyInitiativeId"])
  policyInitiatives: SovereignViewPolicyInitiativeDetail[];

  @visibility(Lifecycle.Read)
  @doc("The status of a user-initiated, control-plane operation on the sovereign view resource type.")
  provisioningState?: provisioningState;
}

@added(Versions.Preview20260315)
@doc("The scope for the sovereign view in terms of the resources it would evaluate.")
model SovereignViewScope {
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
@doc("The policy initiative details for the sovereign view.")
model SovereignViewPolicyInitiativeDetail {
  @doc("The fully qualified id of the policy initiative.")
  policyInitiativeId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policySetDefinitions";
    }
  ]>;

  @doc("The compliance dimension associated with the policy initiative.")
  dimension: ComplianceDimension;

  @doc("The policy assignment ids created for the policy initiative.")
  policyAssignmentIds?: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policyAssignments";
    }
  ]>[];

  @doc("The version of the policy initiative.")
  policyVersion: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Parameters vary based on the selected policy initiatives."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Parameters vary based on the selected policy initiatives."
  @doc("The parameters for the assignment of policy initiatives.")
  assignmentParameters: Record<unknown>;
}

@added(Versions.Preview20260315)
@doc("The compliance dimension to be associated with the policy initiative.")
union ComplianceDimension {
  @doc("Data residency compliance dimension.")
  DataResidency: "DataResidency",

  @doc("Encryption at rest compliance dimension.")
  EncryptionAtRest: "EncryptionAtRest",

  @doc("Encryption in transit compliance dimension.")
  EncryptionInTransit: "EncryptionInTransit",

  @doc("Encryption in use compliance dimension.")
  EncryptionInUse: "EncryptionInUse",

  string,
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

  @doc("The list of compliance summaries for the dimensions in scope.")
  @identifiers(#["dimension"])
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

  @doc("Number of resources in other compliance states for the sovereign view.")
  othersCount: int32;
}

@added(Versions.Preview20260315)
@doc("The compliance summary for a specific dimension in the sovereign view compliance summary action.")
model SovereignViewComplianceDimensionSummary {
  @doc("The dimension representing this summary.")
  dimension: ComplianceDimension;

  @doc("Total number of resources for the sovereign view.")
  totalResources: int32;

  @doc("Number of compliant resources for the sovereign view.")
  compliantCount: int32;

  @doc("Number of non-compliant resources for the sovereign view.")
  nonCompliantCount: int32;

  @doc("Number of resources in other compliance states for the sovereign view.")
  othersCount: int32;
}

@added(Versions.Preview20260315)
@doc("The request for the sovereign view compliance details action.")
model SovereignViewComplianceDetailsRequest {
  @doc("The maximum number of resources to return. Used for pagination.")
  top: int32;

  @doc("The resources to skip when the results are returned. Used for pagination.")
  skip?: int32;

  @doc("The filters for compliance dimensions and their states to apply when querying for compliance details.")
  @identifiers(#["dimension"])
  complianceDimensions?: SovereignViewComplianceDetailsDimensionFilter[];

  @doc("The filters to apply when querying for compliance details.")
  @identifiers(#["field", "operator"])
  filters?: SovereignViewComplianceDetailsFilters[];

  @doc("The sorting to apply when querying for compliance details.")
  sort?: SovereignViewComplianceDetailsSort;

  @doc("The search to apply when querying for compliance details.")
  search?: SovereignViewComplianceDetailsSearch;
}

@added(Versions.Preview20260315)
@doc("The filter for compliance details based on compliance dimensions and their states.")
model SovereignViewComplianceDetailsDimensionFilter {
  @doc("The compliance dimension to filter on.")
  dimension: ComplianceDimension;

  @doc("The compliance states to optionally filter on.")
  states?: PolicyComplianceState[];
}

@added(Versions.Preview20260315)
@doc("Supported compliance states for the policy initiatives.")
union PolicyComplianceState {
  @doc("The resource is compliant with respect to the given policy.")
  Compliant: "Compliant",

  @doc("The resource is not compliant with respect to the given policy.")
  NonCompliant: "NonCompliant",

  @doc("The resource is in a compliance state other than compliant or non-compliant.")
  Others: "Others",

  string,
}

@added(Versions.Preview20260315)
@doc("The filters to apply when querying for compliance details.")
model SovereignViewComplianceDetailsFilters {
  @doc("The field to filter on.")
  field: string;

  @doc("The operator to apply for the filter.")
  operator: SovereignViewComplianceDetailsFilterOperators;

  @doc("The values to filter on.")
  value: string[];
}

@added(Versions.Preview20260315)
@doc("Supported filter operators for Sovereign View Compliance details.")
union SovereignViewComplianceDetailsFilterOperators {
  @doc("In filter operator. Returns results where the field value is in the provided list of values.")
  In: "In",

  string,
}

@added(Versions.Preview20260315)
@doc("The sorting for compliance details.")
model SovereignViewComplianceDetailsSort {
  @doc("The field to sort on.")
  field: string;

  @doc("The direction to sort in.")
  direction: SovereignViewComplianceDetailsSortDirections;
}

@added(Versions.Preview20260315)
@doc("Supported sort directions for Sovereign View Compliance details.")
union SovereignViewComplianceDetailsSortDirections {
  @doc("Ascending sort direction.")
  Asc: "asc",

  @doc("Descending sort direction.")
  Desc: "desc",

  string,
}

@added(Versions.Preview20260315)
@doc("Search field and query for Sovereign View Compliance details.")
model SovereignViewComplianceDetailsSearch {
  @doc("The field to search on.")
  field: string;

  @doc("The value to search for in the specified field.")
  value: string;
}

@added(Versions.Preview20260315)
@doc("The response for the sovereign view compliance details action.")
model SovereignViewComplianceDetailsResponse {
  @doc("The time when compliance was last evaluated overall, in RFC3339 format.")
  lastEvaluated: utcDateTime;

  @doc("Total number of resources for the sovereign view.")
  totalResources: int32;

  @doc("The list of compliance detail resources.")
  @identifiers(#["resourceId"])
  resources: SovereignViewComplianceDetailResource[];
}

@added(Versions.Preview20260315)
@doc("A compliance detail item for a resource.")
model SovereignViewComplianceDetailResource {
  @doc("The resource identifier.")
  resourceId: armResourceIdentifier<[]>;

  @doc("The location of the resource.")
  location: string;

  @doc("The compliance details for the resource.")
  @identifiers(#["dimension", "policyInitiativeId"])
  complianceDetails: SovereignViewComplianceDetail[];
}

@added(Versions.Preview20260315)
@doc("A compliance detail item for a resource in the sovereign view compliance details action.")
model SovereignViewComplianceDetail {
  @doc("The compliance dimension for the compliance detail.")
  dimension: ComplianceDimension;

  @doc("The fully qualified id of the policy initiative.")
  policyInitiativeId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policySetDefinitions";
    }
  ]>;

  @doc("The compliance state of the resource for the policy initiative.")
  policyState: PolicyComplianceState;

  @doc("The time when compliance was last evaluated by Azure Policy, in RFC3339 format.")
  evaluatedAt?: utcDateTime;
}
