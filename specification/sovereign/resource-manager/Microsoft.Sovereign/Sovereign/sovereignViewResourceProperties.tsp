using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20261031)
@doc("The patch model for the sovereign view resource type.")
model SovereignViewResourcePatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...ManagedSystemAssignedIdentityProperty;
}

@added(Versions.Preview20261031)
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

@added(Versions.Preview20261031)
@doc("The scope for the sovereign view in terms of the resources it would evaluate.")
model SovereignViewScope {
  @doc("The management groups in scope.")
  managementGroups?: SovereignViewManagementGroupScope[];

  @doc("The subscriptions in scope.")
  subscriptions?: SovereignViewSubscriptionScope[];
}

@added(Versions.Preview20261031)
@doc("A management group scope item for the sovereign view.")
model SovereignViewManagementGroupScope {
  @doc("The resource identifier of the management group.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  @doc("The management group name. This is a purely client side label that the service does not validate, normalize, or use for any lookup.")
  name?: string;
}

@added(Versions.Preview20261031)
@doc("A subscription scope item for the sovereign view.")
model SovereignViewSubscriptionScope {
  @doc("The subscription id.")
  id: uuid;

  @doc("The subscription name. This is a purely client side label that the service does not validate, normalize, or use for any lookup.")
  name?: string;
}

@added(Versions.Preview20261031)
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

  @visibility(Lifecycle.Read)
  @doc("The policy assignment Ids generated during assignment of the policy initiative to a scope.")
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

@added(Versions.Preview20261031)
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

  @doc("Controlled network exposure compliance dimension.")
  ControlledNetworkExposure: "ControlledNetworkExposure",

  string,
}

@added(Versions.Preview20261031)
@doc("The state of the report data.")
union DataState {
  @doc("The data is still being processed and is not yet available.")
  Processing: "Processing",

  @doc("The data is processed and available.")
  Processed: "Processed",

  @doc("An error occurred while processing the data.")
  Error: "Error",

  string,
}

@added(Versions.Preview20261031)
@doc("The compliance report generation state.")
union ReportState {
  @doc("The compliance report is being generated for the first time.")
  Generating: "Generating",

  @doc("No compliance data is available yet.")
  NoDataYet: "NoDataYet",

  @doc("The compliance report is up to date.")
  UpToDate: "UpToDate",

  @doc("The compliance report generation is being retried.")
  Retrying: "Retrying",

  @doc("The compliance report is being refreshed.")
  Refreshing: "Refreshing",

  @doc("The compliance report is stale and pending refresh.")
  Stale: "Stale",

  @doc("The compliance report generation is blocked.")
  Blocked: "Blocked",

  string,
}

@added(Versions.Preview20261031)
@doc("The compliance report generation status, including the current state and the next attempt time.")
model ReportStatus {
  @doc("The current compliance report generation state.")
  state: ReportState;

  @doc("The next scheduled evaluation time, in RFC3339 format. May not be available for all report states.")
  nextAttempt?: utcDateTime;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.Preview20261031)
@doc("The response for the sovereign view compliance summary action.")
model SovereignViewComplianceSummaryResponse {
  @doc("State indicating whether the data is processed or still being processed.")
  reportStatus: ReportStatus;

  @doc("Error details when dataState is Error.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The resource identifier of the sovereign view.")
  resourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/sovereignViews";
    }
  ]>;

  @doc("The time when compliance was last evaluated, in RFC3339 format.")
  lastEvaluated: utcDateTime;

  @doc("The overall summary of compliance across all resources in scope.")
  overallSummary?: SovereignViewComplianceOverallSummary;

  @doc("The list of compliance summaries for the dimensions in scope.")
  @identifiers(#["dimension"])
  dimensionSummaries?: SovereignViewComplianceDimensionSummary[];
}

@added(Versions.Preview20261031)
@doc("The overall compliance summary in the sovereign view compliance summary action.")
model SovereignViewComplianceOverallSummary {
  @doc("Total number of management groups for the sovereign view.")
  @minValue(0)
  totalManagementGroups: int32;

  @doc("Total number of subscriptions for the sovereign view.")
  @minValue(0)
  totalSubscriptions: int32;

  @doc("Total number of resource groups for the sovereign view.")
  @minValue(0)
  totalResourceGroups: int32;

  @doc("Total number of resources for the sovereign view.")
  @minValue(0)
  totalResources: int32;

  @doc("Number of resources in compliant state for the sovereign view.")
  @minValue(0)
  compliantCount: int32;

  @doc("Number of resources in non-compliant state for the sovereign view.")
  @minValue(0)
  nonCompliantCount: int32;

  @doc("Number of resources in conflict state for the sovereign view.")
  @minValue(0)
  conflictCount: int32;

  @doc("Number of resources in not applicable state for the sovereign view.")
  @minValue(0)
  notApplicableCount: int32;

  @doc("Number of resources in not evaluated state for the sovereign view.")
  @minValue(0)
  notEvaluatedCount: int32;

  @doc("Number of resources in other compliance states for the sovereign view.")
  @minValue(0)
  othersCount: int32;
}

@added(Versions.Preview20261031)
@doc("The compliance summary for a specific dimension in the sovereign view compliance summary action.")
model SovereignViewComplianceDimensionSummary {
  @doc("The dimension representing this summary.")
  dimension: ComplianceDimension;

  @doc("Total number of resources for the sovereign view.")
  @minValue(0)
  totalResources: int32;

  @doc("Number of resources in compliant state for the sovereign view.")
  @minValue(0)
  compliantCount: int32;

  @doc("Number of resources in non-compliant state for the sovereign view.")
  @minValue(0)
  nonCompliantCount: int32;

  @doc("Number of resources in conflict state for the sovereign view.")
  @minValue(0)
  conflictCount: int32;

  @doc("Number of resources in not applicable state for the sovereign view.")
  @minValue(0)
  notApplicableCount: int32;

  @doc("Number of resources in not evaluated state for the sovereign view.")
  @minValue(0)
  notEvaluatedCount: int32;

  @doc("Number of resources in other compliance states for the sovereign view.")
  @minValue(0)
  othersCount: int32;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.Preview20261031)
@doc("The request for the sovereign view compliance details action.")
model SovereignViewComplianceDetailsRequest {
  @doc("The maximum number of resources to return. Used for pagination.")
  @minValue(1)
  top: int32;

  @doc("The resources to skip when the results are returned. Used for pagination.")
  @minValue(0)
  skip?: int32;

  @doc("The filters for compliance dimensions and their states to apply when querying for compliance details.")
  @identifiers(#["dimension"])
  complianceDimensions?: SovereignViewComplianceDetailsDimensionFilter[];

  @doc("The filters to apply when querying for compliance details.")
  @identifiers(#["field", "operator"])
  filters?: SovereignViewComplianceDetailsFilters[];

  @doc("The sorting to apply when querying for compliance details.")
  sort?: SovereignViewComplianceDetailsSort[];

  @doc("The search to apply when querying for compliance details.")
  search?: SovereignViewComplianceDetailsSearch;
}

@added(Versions.Preview20261031)
@doc("The filter for compliance details based on compliance dimensions and their states.")
model SovereignViewComplianceDetailsDimensionFilter {
  @doc("The compliance dimension to filter on.")
  dimension: ComplianceDimension;

  @doc("The compliance states to optionally filter on.")
  states: PolicyComplianceState[];
}

@added(Versions.Preview20261031)
@doc("Supported compliance states for the policy initiatives.")
union PolicyComplianceState {
  @doc("The resource is compliant with respect to the given policy.")
  Compliant: "Compliant",

  @doc("The resource is not compliant with respect to the given policy.")
  NonCompliant: "NonCompliant",

  @doc("The resource is in a conflict with respect to the given policy.")
  Conflict: "Conflict",

  @doc("The resource is in a state that is not applicable to the given policy.")
  NotApplicable: "NotApplicable",

  @doc("The resource has not been evaluated for compliance with respect to the given policy.")
  NotEvaluated: "NotEvaluated",

  @doc("The resource is in a compliance state other than Compliant, NonCompliant, Conflict, NotApplicable, or NotEvaluated.")
  Others: "Others",

  string,
}

@added(Versions.Preview20261031)
@doc("The filters to apply when querying for compliance details.")
model SovereignViewComplianceDetailsFilters {
  @doc("The field to filter on.")
  field: SovereignViewFilterField;

  @doc("The operator to apply for the filter.")
  operator: SovereignViewComplianceDetailsFilterOperators;

  @doc("The values to filter on.")
  value: string[];
}

@added(Versions.Preview20261031)
@doc("Supported filter fields for Sovereign View compliance details.")
union SovereignViewFilterField {
  @doc("Filter by subscription.")
  subscription: "Subscription",

  @doc("Filter by resource group.")
  resourceGroup: "ResourceGroup",

  @doc("Filter by resource name.")
  resourceName: "ResourceName",

  @doc("Filter by resource type.")
  resourceType: "ResourceType",

  @doc("Filter by region.")
  region: "Region",

  @doc("Filter by Encryption In Transit compliance dimension.")
  encryptionInTransit: "EncryptionInTransit",

  @doc("Filter by Data Residency compliance dimension.")
  dataResidency: "DataResidency",

  @doc("Filter by Encryption At Rest compliance dimension.")
  encryptionAtRest: "EncryptionAtRest",

  @doc("Filter by Encryption In Use compliance dimension.")
  encryptionInUse: "EncryptionInUse",

  @doc("Filter by Controlled Network Exposure compliance dimension.")
  controlledNetworkExposure: "ControlledNetworkExposure",

  @added(Versions.Preview20261031)
  @doc("Filter by the name of the parent resource that contains the resource.")
  parentResourceName: "ParentResourceName",

  string,
}

@added(Versions.Preview20261031)
@doc("Supported filter operators for Sovereign View Compliance details.")
union SovereignViewComplianceDetailsFilterOperators {
  @doc("In filter operator. Returns results where the field value is in the provided list of values.")
  In: "In",

  string,
}

@added(Versions.Preview20261031)
@doc("The sorting for compliance details.")
model SovereignViewComplianceDetailsSort {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "The field identifies sort entries in a request array and does not have a resource lifecycle visibility."
  @key
  @doc("The field to sort on.")
  field: string;

  @doc("The direction to sort in.")
  direction: SovereignViewComplianceDetailsSortDirections;

  @added(Versions.Preview20261031)
  @doc("Explicit ordering of policy compliance states to apply when sorting on a compliance-state field. The states are ranked in the order listed. When provided for a compliance-state field, this takes precedence over `direction`, which is ignored for that field.")
  sortingOrder?: PolicyComplianceState[];
}

@added(Versions.Preview20261031)
@doc("Supported sort directions for Sovereign View Compliance details.")
union SovereignViewComplianceDetailsSortDirections {
  @doc("Ascending sort direction.")
  Asc: "asc",

  @doc("Descending sort direction.")
  Desc: "desc",

  string,
}

@added(Versions.Preview20261031)
@doc("Search field and query for Sovereign View Compliance details.")
model SovereignViewComplianceDetailsSearch {
  @doc("The field to search on.")
  field: string;

  @doc("The value to search for in the specified field.")
  value: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.Preview20261031)
@doc("The response for the sovereign view compliance details action.")
model SovereignViewComplianceDetailsResponse {
  @doc("State indicating whether the data is processed or still being processed.")
  reportStatus: ReportStatus;

  @doc("Error details when dataState is Error.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The time when compliance was last evaluated overall, in RFC3339 format.")
  lastEvaluated: utcDateTime;

  @doc("Total number of resources for the sovereign view.")
  @minValue(0)
  totalResources?: int32;

  @doc("The list of compliance detail resources.")
  @identifiers(#["resourceId"])
  resources?: SovereignViewComplianceDetailResource[];
}

@added(Versions.Preview20261031)
@doc("A compliance detail item for a resource.")
model SovereignViewComplianceDetailResource {
  @doc("The resource identifier.")
  resourceId: armResourceIdentifier;

  @added(Versions.Preview20261031)
  @doc("The fully qualified Azure Resource Manager ID of the parent resource. When a resource is created as part of another Azure resource's creation and its lifecycle is managed by the platform, this is the ID of that parent resource. For a resource that was created standalone and has no parent resource, this will be empty.")
  parentResourceId?: armResourceIdentifier;

  @doc("The location of the resource.")
  location: string;

  @doc("The compliance details for the resource across the dimensions.")
  @identifiers(#["dimension"])
  dimensionDetails: SovereignViewDimensionDetail[];
}

@added(Versions.Preview20261031)
@doc("A compliance detail item for a resource in the sovereign view compliance details action.")
model SovereignViewDimensionDetail {
  @doc("The compliance dimension for the compliance detail.")
  dimension: ComplianceDimension;

  @doc("The compliance state of the resource for the dimension.")
  state: PolicyComplianceState;

  @doc("The compliance details for the given dimension.")
  @identifiers(#["policyAssignmentId"])
  complianceDetails: SovereignViewComplianceDetail[];
}

@added(Versions.Preview20261031)
@doc("A compliance detail item for a resource in the sovereign view compliance details action.")
model SovereignViewComplianceDetail {
  @doc("The fully qualified id of the policy initiative associated with the compliance detail.")
  policyInitiativeId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policySetDefinitions";
    }
  ]>;

  @doc("The policy assignment for the compliance detail.")
  policyAssignmentId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policyAssignments";
    }
  ]>;

  @doc("The time when compliance was last evaluated by Azure Policy, in RFC3339 format.")
  evaluatedAt?: utcDateTime;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.Preview20261031)
@doc("The request for the sovereign view filter values action.")
model SovereignViewFilterValuesRequest {
  @doc("The filter field for which values are requested.")
  requestedFilter: SovereignViewFilterField;

  @doc("Optional filters to apply before returning filter values.")
  @identifiers(#["field", "operator"])
  filters?: SovereignViewComplianceDetailsFilters[];

  @doc("Optional search term applied to the requested filter field.")
  searchTerm?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.Preview20261031)
@doc("The response for the sovereign view filter values action.")
model SovereignViewFilterValuesResponse {
  @doc("State indicating whether the data is processed or still being processed.")
  dataState: DataState;

  @doc("Error details when dataState is Error.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The filter field for which values are returned.")
  requestedFilter?: SovereignViewFilterField;

  @doc("Total number of values available for the requested filter.")
  @minValue(0)
  totalCount?: int32;

  @doc("The list of filter values and their counts.")
  @identifiers(#["value"])
  values?: SovereignViewFilterValueItem[];
}

@added(Versions.Preview20261031)
@doc("A filter value item with the associated count.")
model SovereignViewFilterValueItem {
  @doc("The value for the filter.")
  value: string;

  @doc("The display name for the filter value.")
  displayName?: string;

  @doc("The count of resources that match the filter value.")
  @minValue(0)
  count: int32;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept consistent with the sibling action request/response models in this resource provider."
@added(Versions.Preview20261031)
@doc("The request for the sovereign view operational status action.")
model SovereignViewOperationalStatusRequest {
  @doc("The level of detail to return in the operational status response. Defaults to Detailed.")
  mode?: OperationalStatusRequestMode;

  @doc("The evaluation parameters that control which checks are performed when determining operational status.")
  evaluationParameters?: OperationalStatusEvaluationParameter[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept consistent with the sibling action request/response models in this resource provider."
@added(Versions.Preview20261031)
@doc("The response for the sovereign view operational status action.")
model SovereignViewOperationalStatusResponse {
  @doc("The name of the sovereign view.")
  name: string;

  @doc("The overall operational status of the sovereign view.")
  status: OperationalStatusStates;

  @doc("The detailed operational status information. Returned when the operational status is evaluated in Detailed mode.")
  @identifiers(#["reason"])
  details?: SovereignViewOperationalStatusDetails[];
}

@added(Versions.Preview20261031)
@doc("An operational status detail item describing an issue impacting the operability of the sovereign view.")
model SovereignViewOperationalStatusDetails {
  @doc("The reason the sovereign view is unhealthy.")
  reason: OperationalStatusUnhealthyReason;

  @doc("The scopes affected by the issue.")
  @identifiers(#["id"])
  affectedScopes?: SovereignViewAffectedScopes[];
}

@added(Versions.Preview20261031)
@doc("An affected scope in a sovereign view operational status detail.")
model SovereignViewAffectedScopes {
  @doc("The name of the management group or subscription affected.")
  name: string;

  @doc("The identifier of the management group or subscription affected.")
  id: string;

  @doc("The type of the affected scope.")
  type: SovereignViewScopeType;

  @doc("The operational status of the affected scope.")
  status: ScopeLevelOperationalStatusStates;

  @doc("The action required to remediate the affected scope, such as a role name or a policy initiative id.")
  actionRequired?: string;
}

@added(Versions.Preview20261031)
@doc("The level of detail to return in the sovereign view operational status response.")
union OperationalStatusRequestMode {
  @doc("Returns a high-level operational status suitable for quickly determining overall view health.")
  Summary: "Summary",

  @doc("Returns a comprehensive operational status, including detailed information about individual checks, dependencies, and any issues impacting view operability.")
  Detailed: "Detailed",

  string,
}

@added(Versions.Preview20261031)
@doc("An evaluation parameter that controls which checks are performed when determining operational status.")
union OperationalStatusEvaluationParameter {
  @doc("Evaluate managed identity permissions on the scopes in the sovereign view.")
  PermissionsEvaluation: "PermissionsEvaluation",

  @doc("Evaluate policy assignments on the scopes in the sovereign view.")
  PolicyAssignmentEvaluation: "PolicyAssignmentEvaluation",

  string,
}

@added(Versions.Preview20261031)
@doc("The overall operational status states for a sovereign view.")
union OperationalStatusStates {
  @doc("The sovereign view is healthy and fully operational.")
  Healthy: "Healthy",

  @doc("The sovereign view is unhealthy and its operability is impacted.")
  Unhealthy: "Unhealthy",

  @doc("The operational status of the sovereign view could not be determined.")
  Unknown: "Unknown",

  string,
}

@added(Versions.Preview20261031)
@doc("The operational status states for an individual scope within a sovereign view.")
union ScopeLevelOperationalStatusStates {
  @doc("The scope is unhealthy and its operability is impacted.")
  Unhealthy: "Unhealthy",

  @doc("The operational status of the scope could not be determined.")
  Unknown: "Unknown",

  @doc("The scope has been deleted.")
  Deleted: "Deleted",

  string,
}

@added(Versions.Preview20261031)
@doc("The reasons a sovereign view or an individual scope is unhealthy.")
union OperationalStatusUnhealthyReason {
  @doc("The managed identity is missing.")
  MIMissing: "MIMissing",

  @doc("The managed identity is missing required permissions.")
  MIPermissionMissing: "MIPermissionMissing",

  @doc("A required policy assignment is missing.")
  PolicyAssignmentMissing: "PolicyAssignmentMissing",

  string,
}

@added(Versions.Preview20261031)
@doc("The type of scope in a sovereign view.")
union SovereignViewScopeType {
  @doc("A management group scope.")
  ManagementGroup: "ManagementGroup",

  @doc("A subscription scope.")
  Subscription: "Subscription",

  string,
}
