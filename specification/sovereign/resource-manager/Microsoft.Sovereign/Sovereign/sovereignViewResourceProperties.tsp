using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

/** The patch model for the sovereign view resource type. */
@added(Versions.Preview20261031)
model SovereignViewResourcePatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...ManagedSystemAssignedIdentityProperty;
}

/** The properties of the sovereign view resource type. */
@added(Versions.Preview20261031)
model SovereignViewResourceProperties {
  /** The scope to apply for configuration. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scope: SovereignViewScope;

  /** The policy initiatives selected for the sovereign view. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @identifiers(#["policyInitiativeId"])
  policyInitiatives: SovereignViewPolicyInitiativeDetail[];

  /** Stable regulatory-document key selected when this Sovereign View was created. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  regulatoryDocumentName?: SovereignViewRegulatoryDocumentName;

  /** The status of a user-initiated, control-plane operation on the sovereign view resource type. */
  @visibility(Lifecycle.Read)
  provisioningState?: provisioningState;

  /** Optional per-dimension evaluation settings. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dimensionSettings?: SovereignViewDimensionSettings;

  /** Indicates whether the Sovereign View is considered a workload. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  isWorkload?: boolean;
}

/** Stable regulatory-document keys recognized by the Portal. */
@added(Versions.Preview20261031)
union SovereignViewRegulatoryDocumentName {
  /** The Azure Cloud Sovereign Baseline document selected by default in the Portal. */
  SovereignControlBaseline: "SovereignControlBaseline",

  string,
}

/** Per-dimension evaluation settings for the sovereign view. */
@added(Versions.Preview20261031)
model SovereignViewDimensionSettings {
  /** Settings for the Data Residency dimension. */
  dataResidency?: SovereignViewDataResidencyDimensionSettings;
}

/** Evaluation settings for the Data Residency dimension. */
@added(Versions.Preview20261031)
model SovereignViewDataResidencyDimensionSettings {
  /** The resource scope evaluated for the Data Residency dimension. */
  resourceEvaluationScope: DataResidencyResourceEvaluationScope;

  /** Parameters used by the Data Residency evaluation. */
  parameters: SovereignViewDataResidencyParameters;
}

/** The resource scope evaluated for the Data Residency dimension. */
@added(Versions.Preview20261031)
union DataResidencyResourceEvaluationScope {
  /** Evaluate the resource together with the resources linked to it. */
  Residency360: "Residency360",

  /** Evaluate only the resource itself, without its linked resources. */
  ResourceOnly: "ResourceOnly",

  string,
}

/** Parameters used by the Data Residency evaluation. */
@added(Versions.Preview20261031)
model SovereignViewDataResidencyParameters {
  /** Azure regions in which the resource and its linked resources are allowed to reside. */
  allowedLocations: string[];
}

/** The scope for the sovereign view in terms of the resources it would evaluate. */
@added(Versions.Preview20261031)
model SovereignViewScope {
  /** The management groups in scope. */
  managementGroups?: SovereignViewManagementGroupScope[];

  /** The subscriptions in scope. */
  subscriptions?: SovereignViewSubscriptionScope[];
}

/** A management group scope item for the sovereign view. */
@added(Versions.Preview20261031)
model SovereignViewManagementGroupScope {
  /** The resource identifier of the management group. */
  id: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  /** The management group name. This is a purely client side label that the service does not validate, normalize, or use for any lookup. */
  name?: string;
}

/** A subscription scope item for the sovereign view. */
@added(Versions.Preview20261031)
model SovereignViewSubscriptionScope {
  /** The subscription id. */
  id: uuid;

  /** The subscription name. This is a purely client side label that the service does not validate, normalize, or use for any lookup. */
  name?: string;
}

/** The policy initiative details for the sovereign view. */
@added(Versions.Preview20261031)
model SovereignViewPolicyInitiativeDetail {
  /** The fully qualified id of the policy initiative. */
  policyInitiativeId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policySetDefinitions";
    }
  ]>;

  /** The compliance dimension associated with the policy initiative. */
  dimension: ComplianceDimension;

  /** The resource identifiers of existing policy assignments association with the policy initiative and scopes in the sovereign view. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  policyAssignmentIds: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policyAssignments";
    }
  ]>[];

  /** The version of the policy initiative. */
  policyVersion: string;
}

/** The compliance dimension to be associated with the policy initiative. */
@added(Versions.Preview20261031)
union ComplianceDimension {
  /** Data residency compliance dimension. */
  DataResidency: "DataResidency",

  /** Encryption at rest compliance dimension. */
  EncryptionAtRest: "EncryptionAtRest",

  /** Encryption in transit compliance dimension. */
  EncryptionInTransit: "EncryptionInTransit",

  /** Encryption in use compliance dimension. */
  EncryptionInUse: "EncryptionInUse",

  /** Controlled network exposure compliance dimension. */
  ControlledNetworkExposure: "ControlledNetworkExposure",

  /** Business continuity compliance dimension. */
  BusinessContinuity: "BusinessContinuity",

  string,
}

/** The state of the report data. */
@added(Versions.Preview20261031)
union DataState {
  /** The data is still being processed and is not yet available. */
  Processing: "Processing",

  /** The data is processed and available. */
  Processed: "Processed",

  /** An error occurred while processing the data. */
  Error: "Error",

  string,
}

/** The compliance report generation state. */
@added(Versions.Preview20261031)
union ReportState {
  /** The compliance report is being generated for the first time. */
  Generating: "Generating",

  /** No compliance data is available yet. */
  NoDataYet: "NoDataYet",

  /** The compliance report is up to date. */
  UpToDate: "UpToDate",

  /** The compliance report generation is being retried. */
  Retrying: "Retrying",

  /** The compliance report is being refreshed. */
  Refreshing: "Refreshing",

  /** The compliance report is stale and pending refresh. */
  Stale: "Stale",

  /** The compliance report generation is blocked. */
  Blocked: "Blocked",

  string,
}

/** The compliance report generation status, including the current state and the next attempt time. */
@added(Versions.Preview20261031)
model ReportStatus {
  /** The current compliance report generation state. */
  state: ReportState;

  /** The next scheduled evaluation time, in RFC3339 format. May not be available for all report states. */
  nextAttempt?: utcDateTime;
}

/** The response for the sovereign view compliance summary action. */
@added(Versions.Preview20261031)
model SovereignViewComplianceSummaryResult {
  /** State indicating whether the data is processed or still being processed. */
  reportStatus: ReportStatus;

  /** Error details when dataState is Error. */
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  /** The resource identifier of the sovereign view. */
  resourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/sovereignViews";
    }
  ]>;

  /** The time when compliance was last evaluated, in RFC3339 format. */
  lastEvaluated: utcDateTime;

  /** The overall summary of compliance across all resources in scope. */
  overallSummary?: SovereignViewComplianceOverallSummary;

  /** The list of compliance summaries for the dimensions in scope. */
  @identifiers(#["dimension"])
  dimensionSummaries?: SovereignViewComplianceDimensionSummary[];
}

/** The overall compliance summary in the sovereign view compliance summary action. */
@added(Versions.Preview20261031)
model SovereignViewComplianceOverallSummary {
  /** Total number of management groups for the sovereign view. */
  @minValue(0)
  totalManagementGroups: int32;

  /** Total number of subscriptions for the sovereign view. */
  @minValue(0)
  totalSubscriptions: int32;

  /** Total number of resource groups for the sovereign view. */
  @minValue(0)
  totalResourceGroups: int32;

  /** Total number of resources for the sovereign view. */
  @minValue(0)
  totalResources: int32;

  /** Number of resources in compliant state for the sovereign view. */
  @minValue(0)
  compliantCount: int32;

  /** Number of resources in non-compliant state for the sovereign view. */
  @minValue(0)
  nonCompliantCount: int32;

  /** Number of resources in constrained state for the sovereign view. */
  @minValue(0)
  constrainedCount: int32;

  /** Number of resources in conflict state for the sovereign view. */
  @minValue(0)
  conflictCount: int32;

  /** Number of resources in not applicable state for the sovereign view. */
  @minValue(0)
  notApplicableCount: int32;

  /** Number of resources in not evaluated state for the sovereign view. */
  @minValue(0)
  notEvaluatedCount: int32;

  /** Number of resources in other compliance states for the sovereign view. */
  @minValue(0)
  othersCount: int32;
}

/** The compliance summary for a specific dimension in the sovereign view compliance summary action. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDimensionSummary {
  /** The dimension representing this summary. */
  dimension: ComplianceDimension;

  /** Total number of resources for the sovereign view. */
  @minValue(0)
  totalResources: int32;

  /** Number of resources in compliant state for the sovereign view. */
  @minValue(0)
  compliantCount: int32;

  /** Number of resources in non-compliant state for the sovereign view. */
  @minValue(0)
  nonCompliantCount: int32;

  /** Number of resources in constrained state for the sovereign view. */
  @minValue(0)
  constrainedCount: int32;

  /** Number of resources in conflict state for the sovereign view. */
  @minValue(0)
  conflictCount: int32;

  /** Number of resources in not applicable state for the sovereign view. */
  @minValue(0)
  notApplicableCount: int32;

  /** Number of resources in not evaluated state for the sovereign view. */
  @minValue(0)
  notEvaluatedCount: int32;

  /** Number of resources in other compliance states for the sovereign view. */
  @minValue(0)
  othersCount: int32;
}

/** The request for the sovereign view compliance details action. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDetailsContent {
  /** The maximum number of resources to return. Used for pagination. */
  @minValue(1)
  top: int32;

  /** The resources to skip when the results are returned. Used for pagination. */
  @minValue(0)
  skip?: int32;

  /** The filters for compliance dimensions and their states to apply when querying for compliance details. */
  @identifiers(#["dimension"])
  complianceDimensions?: SovereignViewComplianceDetailsDimensionFilter[];

  /** The filters to apply when querying for compliance details. */
  @identifiers(#["field", "operator"])
  filters?: SovereignViewComplianceDetailsFilters[];

  /** The sorting to apply when querying for compliance details. */
  @identifiers(#["field"])
  sort?: SovereignViewComplianceDetailsSort[];

  /** The search to apply when querying for compliance details. */
  search?: SovereignViewComplianceDetailsSearch;
}

/** The filter for compliance details based on compliance dimensions and their states. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDetailsDimensionFilter {
  /** The compliance dimension to filter on. */
  dimension: ComplianceDimension;

  /** The compliance states to optionally filter on. */
  states: PolicyComplianceState[];
}

/** Supported compliance states for the policy initiatives. */
@added(Versions.Preview20261031)
union PolicyComplianceState {
  /** The resource is compliant with respect to the given policy. */
  Compliant: "Compliant",

  /** The resource is not compliant with respect to the given policy. */
  NonCompliant: "NonCompliant",

  /** The resource is in a conflict with respect to the given policy. */
  Conflict: "Conflict",

  /** The resource is in a state that is not applicable to the given policy. */
  NotApplicable: "NotApplicable",

  /** The resource has not been evaluated for compliance with respect to the given policy. */
  NotEvaluated: "NotEvaluated",

  /** The resource is non-compliant for Business Continuity, but a validated actionable escape path is available. */
  Constrained: "Constrained",

  /** The resource is in a compliance state other than Compliant, NonCompliant, Conflict, NotApplicable, or NotEvaluated. */
  Others: "Others",

  string,
}

/** The filters to apply when querying for compliance details. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDetailsFilters {
  /** The field to filter on. */
  field: SovereignViewFilterField;

  /** The operator to apply for the filter. */
  operator: SovereignViewComplianceDetailsFilterOperators;

  /** The values to filter on. */
  value: string[];
}

/** Supported filter fields for Sovereign View compliance details. */
@added(Versions.Preview20261031)
union SovereignViewFilterField {
  /** Filter by subscription. */
  subscription: "Subscription",

  /** Filter by resource group. */
  resourceGroup: "ResourceGroup",

  /** Filter by resource name. */
  resourceName: "ResourceName",

  /** Filter by resource type. */
  resourceType: "ResourceType",

  /** Filter by region. */
  region: "Region",

  /** Filter by Encryption In Transit compliance dimension. */
  encryptionInTransit: "EncryptionInTransit",

  /** Filter by Data Residency compliance dimension. */
  dataResidency: "DataResidency",

  /** Filter by Encryption At Rest compliance dimension. */
  encryptionAtRest: "EncryptionAtRest",

  /** Filter by Encryption In Use compliance dimension. */
  encryptionInUse: "EncryptionInUse",

  /** Filter by Controlled Network Exposure compliance dimension. */
  controlledNetworkExposure: "ControlledNetworkExposure",

  /** Filter by Business Continuity compliance dimension. */
  businessContinuity: "BusinessContinuity",

  /** Filter by the name of the parent resource that contains the resource. */
  parentResourceName: "ParentResourceName",

  string,
}

/** Supported filter operators for Sovereign View Compliance details. */
@added(Versions.Preview20261031)
union SovereignViewComplianceDetailsFilterOperators {
  /** In filter operator. Returns results where the field value is in the provided list of values. */
  In: "In",

  string,
}

/** The sorting for compliance details. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDetailsSort {
  /** The field to sort on. */
  field: string;

  /** The direction to sort in. */
  direction: SovereignViewComplianceDetailsSortDirections;

  /** Explicit ordering of policy compliance states to apply when sorting on a compliance-state field. The states are ranked in the order listed. When provided for a compliance-state field, this takes precedence over `direction`, which is ignored for that field. */
  sortingOrder?: PolicyComplianceState[];
}

/** Supported sort directions for Sovereign View Compliance details. */
@added(Versions.Preview20261031)
union SovereignViewComplianceDetailsSortDirections {
  /** Ascending sort direction. */
  Asc: "asc",

  /** Descending sort direction. */
  Desc: "desc",

  string,
}

/** Search field and query for Sovereign View Compliance details. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDetailsSearch {
  /** The field to search on. */
  field: string;

  /** The value to search for in the specified field. */
  value: string;
}

/** The response for the sovereign view compliance details action. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDetailsResult {
  /** State indicating whether the data is processed or still being processed. */
  reportStatus: ReportStatus;

  /** Error details when dataState is Error. */
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  /** The time when compliance was last evaluated overall, in RFC3339 format. */
  lastEvaluated: utcDateTime;

  /** Total number of resources for the sovereign view. */
  @minValue(0)
  totalResources?: int32;

  /** The list of compliance detail resources. */
  @identifiers(#["resourceId"])
  resources?: SovereignViewComplianceDetailResource[];
}

/** A compliance detail item for a resource. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDetailResource {
  /** The resource identifier. */
  resourceId: armResourceIdentifier;

  /** The fully qualified Azure Resource Manager ID of the parent resource. When a resource is created as part of another Azure resource's creation and its lifecycle is managed by the platform, this is the ID of that parent resource. For a resource that was created standalone and has no parent resource, this will be empty. */
  parentResourceId?: armResourceIdentifier;

  /** The location of the resource. */
  location: string;

  /** The compliance details for the resource across the dimensions. */
  @identifiers(#["dimension"])
  dimensionDetails: SovereignViewDimensionDetail[];
}

/** A compliance detail item for a resource in the sovereign view compliance details action. */
@added(Versions.Preview20261031)
model SovereignViewDimensionDetail {
  /** The compliance dimension for the compliance detail. */
  dimension: ComplianceDimension;

  /** The compliance state of the resource for the dimension. */
  state: PolicyComplianceState;

  /** The compliance details for the given dimension. */
  @identifiers(#["policyAssignmentId"])
  complianceDetails: SovereignViewComplianceDetail[];

  /** The snapshot timestamp stored for this resource and dimension, in RFC3339 format. */
  evaluatedAt: utcDateTime;

  /** Distinct evaluation sources for this resource and dimension in the same snapshot. An empty array means that the state has no underlying evaluation. */
  sources: SovereignViewResourceEvaluationSource[];
}

/** The evaluation source that produced a compliance state for a resource and dimension. */
@added(Versions.Preview20261031)
union SovereignViewResourceEvaluationSource {
  /** The evaluation was produced by Azure Policy. */
  Policy: "Policy",

  /** The evaluation was produced by Sovereign Intelligence. */
  SovereignIntelligence: "SovereignIntelligence",

  string,
}

/** A compliance detail item for a resource in the sovereign view compliance details action. */
@added(Versions.Preview20261031)
model SovereignViewComplianceDetail {
  /** The fully qualified id of the policy initiative associated with the compliance detail. */
  policyInitiativeId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policySetDefinitions";
    }
  ]>;

  /** The policy assignment for the compliance detail. */
  policyAssignmentId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policyAssignments";
    }
  ]>;

  /** The time when compliance was last evaluated by Azure Policy, in RFC3339 format. */
  evaluatedAt?: utcDateTime;
}

/** The request for the sovereign view filter values action. */
@added(Versions.Preview20261031)
model SovereignViewFilterValuesContent {
  /** The filter field for which values are requested. */
  requestedFilter: SovereignViewFilterField;

  /** Optional filters to apply before returning filter values. */
  @identifiers(#["field", "operator"])
  filters?: SovereignViewComplianceDetailsFilters[];

  /** Optional search term applied to the requested filter field. */
  searchTerm?: string;
}

/** The response for the sovereign view filter values action. */
@added(Versions.Preview20261031)
model SovereignViewFilterValuesResult {
  /** State indicating whether the data is processed or still being processed. */
  dataState: DataState;

  /** Error details when dataState is Error. */
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  /** The filter field for which values are returned. */
  requestedFilter?: SovereignViewFilterField;

  /** Total number of values available for the requested filter. */
  @minValue(0)
  totalCount?: int32;

  /** The list of filter values and their counts. */
  @identifiers(#["value"])
  values?: SovereignViewFilterValueItem[];
}

/** A filter value item with the associated count. */
@added(Versions.Preview20261031)
model SovereignViewFilterValueItem {
  /** The value for the filter. */
  value: string;

  /** The display name for the filter value. */
  displayName?: string;

  /** The count of resources that match the filter value. */
  @minValue(0)
  count: int32;
}

/** The request for the sovereign view operational status action. */
@added(Versions.Preview20261031)
model SovereignViewOperationalStatusContent {
  /** The level of detail to return in the operational status response. Defaults to Detailed. */
  mode?: OperationalStatusRequestMode;

  /** The evaluation parameters that control which checks are performed when determining operational status. */
  evaluationParameters?: OperationalStatusEvaluationParameter[];
}

/** The response for the sovereign view operational status action. */
@added(Versions.Preview20261031)
model SovereignViewOperationalStatusResult {
  /** The name of the sovereign view. */
  name: string;

  /** The overall operational status of the sovereign view. */
  status: OperationalStatusStates;

  /** The detailed operational status information. Returned when the operational status is evaluated in Detailed mode. */
  @identifiers(#["reason"])
  details?: SovereignViewOperationalStatusDetails[];
}

/** An operational status detail item describing an issue impacting the operability of the sovereign view. */
@added(Versions.Preview20261031)
model SovereignViewOperationalStatusDetails {
  /** The reason the sovereign view is unhealthy. */
  reason: OperationalStatusUnhealthyReason;

  /** The scopes affected by the issue. */
  @identifiers(#["id"])
  affectedScopes?: SovereignViewAffectedScopes[];
}

/** An affected scope in a sovereign view operational status detail. */
@added(Versions.Preview20261031)
model SovereignViewAffectedScopes {
  /** The name of the management group or subscription affected. */
  name: string;

  /** The identifier of the management group or subscription affected. */
  id: string;

  /** The type of the affected scope. */
  type: SovereignViewScopeType;

  /** The operational status of the affected scope. */
  status: ScopeLevelOperationalStatusStates;

  /** The action required to remediate the affected scope, such as a role name or a policy initiative id. */
  actionRequired?: string;
}

/** The level of detail to return in the sovereign view operational status response. */
@added(Versions.Preview20261031)
union OperationalStatusRequestMode {
  /** Returns a high-level operational status suitable for quickly determining overall view health. */
  Summary: "Summary",

  /** Returns a comprehensive operational status, including detailed information about individual checks, dependencies, and any issues impacting view operability. */
  Detailed: "Detailed",

  string,
}

/** An evaluation parameter that controls which checks are performed when determining operational status. */
@added(Versions.Preview20261031)
union OperationalStatusEvaluationParameter {
  /** Evaluate managed identity permissions on the scopes in the sovereign view. */
  PermissionsEvaluation: "PermissionsEvaluation",

  /** Evaluate policy assignments on the scopes in the sovereign view. */
  PolicyAssignmentEvaluation: "PolicyAssignmentEvaluation",

  string,
}

/** The overall operational status states for a sovereign view. */
@added(Versions.Preview20261031)
union OperationalStatusStates {
  /** The sovereign view is healthy and fully operational. */
  Healthy: "Healthy",

  /** The sovereign view is unhealthy and its operability is impacted. */
  Unhealthy: "Unhealthy",

  /** The operational status of the sovereign view could not be determined. */
  Unknown: "Unknown",

  string,
}

/** The operational status states for an individual scope within a sovereign view. */
@added(Versions.Preview20261031)
union ScopeLevelOperationalStatusStates {
  /** The scope is unhealthy and its operability is impacted. */
  Unhealthy: "Unhealthy",

  /** The operational status of the scope could not be determined. */
  Unknown: "Unknown",

  /** The scope has been deleted. */
  Deleted: "Deleted",

  string,
}

/** The reasons a sovereign view or an individual scope is unhealthy. */
@added(Versions.Preview20261031)
union OperationalStatusUnhealthyReason {
  /** The managed identity is missing. */
  MIMissing: "MIMissing",

  /** The managed identity is missing required permissions. */
  MIPermissionMissing: "MIPermissionMissing",

  /** A required policy assignment is missing. */
  PolicyAssignmentMissing: "PolicyAssignmentMissing",

  string,
}

/** The type of scope in a sovereign view. */
@added(Versions.Preview20261031)
union SovereignViewScopeType {
  /** A management group scope. */
  ManagementGroup: "ManagementGroup",

  /** A subscription scope. */
  Subscription: "Subscription",

  string,
}

/** The request for the compliance reasoning of one resource and dimension. */
@added(Versions.Preview20261031)
model SovereignViewComplianceResourceDetailsContent {
  /** The full Azure Resource Manager resource identifier of the resource for which compliance reasoning is requested. */
  resourceId: armResourceIdentifier;

  /** The compliance dimension for which reasoning is requested. */
  dimension: ComplianceDimension;

  /** The snapshot timestamp from the compliance-details response. When omitted, the latest completed snapshot is returned. */
  evaluatedAt?: utcDateTime;
}

/** The compliance reasoning for given resource and dimension, including the reasoning for its linked and replica resources. */
@added(Versions.Preview20261031)
model SovereignViewComplianceResourceDetailsResult {
  /** The evaluated resource Azure Resource Manager identifier. */
  resourceId: armResourceIdentifier;

  /** The compliance dimension for which reasoning is returned. */
  dimension: ComplianceDimension;

  /** The snapshot timestamp from which the response was produced. */
  evaluatedAt: utcDateTime;

  /** The compliance state for this dimension. */
  state: PolicyComplianceState;

  /** The linked and replica resource evaluations for this resource and dimension. */
  @identifiers(#["evaluationSourceId", "source"])
  evaluations: SovereignViewDataEvaluation[];
}

/** A linked or replica resource evaluation contributing to the compliance reasoning. */
@added(Versions.Preview20261031)
model SovereignViewDataEvaluation {
  /** The stable identifier of the query that produced this evaluation. */
  evaluationSourceId: string;

  /** What the query was run to find. */
  intent: SovereignViewEvaluationIntent;

  /** The source that produced this linked or replica resource evaluation. */
  source: SovereignViewLinkedResourceEvaluationSource;

  /** The outcomes produced by the query, one per evaluated linked or replica resource. */
  @identifiers(#["resourceId"])
  evaluationOutcomes: SovereignViewDataEvaluationOutcome[];
}

/** What an evaluation query was run to find. */
@added(Versions.Preview20261031)
union SovereignViewEvaluationIntent {
  /** Resources linked to the evaluated resource. */
  LinkedResources: "LinkedResources",

  /** Geo-replicas of the evaluated resource. */
  GeoReplica: "GeoReplica",

  /** Business continuity characteristics of the evaluated resource. */
  BusinessContinuity: "BusinessContinuity",

  string,
}

/** The source that produced a linked or replica resource evaluation. */
@added(Versions.Preview20261031)
union SovereignViewLinkedResourceEvaluationSource {
  /** Azure Resource Graph. */
  ARG: "ARG",

  /** Log Analytics. */
  LogAnalytics: "LogAnalytics",

  /** The business continuity evaluation source. */
  BusinessContinuity: "BusinessContinuity",

  string,
}

/** The compliance reasoning outcome produced by an evaluation query for a single resource. */
@added(Versions.Preview20261031)
model SovereignViewDataEvaluationOutcome {
  /** The Azure Resource Manager identifier of the linked or replica resource associated with the outcome. */
  resourceId?: armResourceIdentifier;

  /** The compliance state of the outcome. */
  state: PolicyComplianceState;

  /** The actual value observed by the evaluation. */
  actualValue?: string;

  /** The value expected by the evaluation. */
  expectedValue?: string;

  /** The reason for the outcome, in the service default language. Empty when the outcome has no reason. Clients that need a localized reason should resolve reasonCodeId instead. */
  reason?: string;

  /** The stable, language-neutral code that identifies the reason. Clients use this code to look up the localized reason string. */
  reasonCodeId?: string;

  /** Additional remediation or explanatory information, in the service default language. Clients that need localized text should resolve additionalInfoCodeId instead. */
  additionalInfo?: string;

  /** The stable, language-neutral code that identifies the additional information. Clients use this code to look up the localized additional information string. */
  additionalInfoCodeId?: string;
}

/** The request for the sovereign view remediate action. */
@added(Versions.Preview20261031)
model SovereignViewRemediateContent {
  /** The remediation dimension being addressed. Only "DataResidency" is currently supported for remediation. */
  dimensionType: ComplianceDimension;

  /** The residency-specific remediation request, present when dimensionType is "DataResidency". */
  residencyRemediationRequest: SovereignViewResidencyRemediationContent;
}

/** The residency remediation request payload. */
@added(Versions.Preview20261031)
model SovereignViewResidencyRemediationContent {
  /** The residency remediation configuration. */
  configuration: SovereignViewResidencyRemediationConfiguration;

  /** The resources to remediate. */
  @identifiers(#["id"])
  resources: SovereignViewResidencyRemediationResource[];
}

/** The configuration for a residency remediation request. */
@added(Versions.Preview20261031)
model SovereignViewResidencyRemediationConfiguration {
  /** The target region resources should be remediated into. */
  targetRegion: string;

  /** The default resource group the remediated resources should be created in, if different from their source resource group. Can be overridden per-resource. */
  targetResourceGroupName?: string;
}

/** A single resource targeted by a residency remediation request. */
@added(Versions.Preview20261031)
model SovereignViewResidencyRemediationResource {
  /** The Azure Resource Manager resource ID of the resource to remediate. */
  id: armResourceIdentifier;

  /** The residency remediation configuration for this resource. */
  configuration: SovereignViewResidencyRemediationResourceConfiguration;
}

/** The per-resource configuration for a residency remediation request. */
@added(Versions.Preview20261031)
model SovereignViewResidencyRemediationResourceConfiguration {
  /** The current region of the resource. */
  sourceRegion: string;

  /** The resource group the remediated resource should be created in, if different from the source resource group. */
  targetResourceGroupName?: string;
}

/** The response for the sovereign view remediate action. */
@added(Versions.Preview20261031)
model SovereignViewRemediateResult {
  /** The identifier used to fetch the remediation result via the remediationResult action. */
  remediationId: string;

  /** The error encountered while starting remediation, if any. */
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

/** The request for the sovereign view remediationResult action. */
@added(Versions.Preview20261031)
model SovereignViewRemediationResultContent {
  /** The remediation identifier returned by the remediate action. */
  remediationId: string;
}

/** The status of a sovereign view remediation. */
@added(Versions.Preview20261031)
union SovereignViewRemediationStatus {
  /** The remediation completed successfully. */
  Succeeded: "Succeeded",

  /** The remediation failed. */
  Failed: "Failed",

  string,
}

/** The response for the sovereign view remediationResult action. */
@added(Versions.Preview20261031)
model SovereignViewRemediationResult {
  /** The remediation identifier this result corresponds to. */
  remediationId: string;

  /** The remediation dimension this result corresponds to. Only "DataResidency" is currently supported for remediation. */
  dimensionType: ComplianceDimension;

  /** The status of the remediation, e.g. "Succeeded". */
  status: SovereignViewRemediationStatus;

  /** The remediation results. */
  @identifiers(#["resourceIds"])
  results?: SovereignViewRemediationResultItem[];

  /** The error encountered while remediating, if any. */
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  /** The time of creation of this remediation result. */
  createdAt?: utcDateTime;

  /** The time at which this remediation result expires and is no longer retrievable. */
  expiresAt?: utcDateTime;
}

/** The type of remediation payload returned in a remediation result item. */
@added(Versions.Preview20261031)
union SovereignViewRemediationPayloadType {
  /** The remediation payload is an Azure Resource Manager template bundle. */
  ArmTemplateBundle: "ArmTemplateBundle",

  string,
}

/** A single remediation result item. */
@added(Versions.Preview20261031)
model SovereignViewRemediationResultItem {
  /** The Azure Resource Manager resource IDs this result item applies to. */
  resourceIds: armResourceIdentifier[];

  /** The type of remediation payload returned. */
  type: SovereignViewRemediationPayloadType;

  /** The remediation payload. */
  result: SovereignViewArmTemplateBundle;
}

/** An Azure Resource Manager template bundle produced by a remediation. */
@added(Versions.Preview20261031)
model SovereignViewArmTemplateBundle {
  /** The Azure Resource Manager template, serialized as a JSON string. */
  template: string;

  /** The Azure Resource Manager template parameters, serialized as a JSON string. */
  parameters: string;
}
