import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace PolicyInsightsApi;

/**
 * List of available operations.
 */
model OperationsListResults {
  /**
   * OData entity count; represents the number of operations returned.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(1)
  `@odata.count`?: int32;

  /**
   * List of available operations.
   */
  @identifiers(#["name"])
  value?: Operation[];
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagementGroupsNamespaceType {
  `Microsoft.Management`,
}

/**
 * The way resources to remediate are discovered. Defaults to ExistingNonCompliant if not specified.
 */
union ResourceDiscoveryMode {
  string,

  /**
   * Remediate resources that are already known to be non-compliant.
   */
  ExistingNonCompliant: "ExistingNonCompliant",

  /**
   * Re-evaluate the compliance state of resources and then remediate the resources found to be non-compliant. The resourceIds filter cannot be used in this mode.
   */
  ReEvaluateCompliance: "ReEvaluateCompliance",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PolicyEventsResourceType {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PolicyStatesResource {
  string,

  /**
   * default
   */
  default: "default",

  /**
   * latest
   */
  latest: "latest",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PolicyStatesSummaryResourceType {
  string,

  /**
   * latest
   */
  latest: "latest",
}

/**
 * The type of restriction that is imposed on the field.
 */
union FieldRestrictionResult {
  string,

  /**
   * The field and/or values are required by policy.
   */
  Required: "Required",

  /**
   * The field will be removed by policy.
   */
  Removed: "Removed",

  /**
   * The field and/or values will be denied by policy.
   */
  Deny: "Deny",

  /**
   * The field and/or values will be audited by policy.
   */
  Audit: "Audit",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ComponentPolicyStatesResource {
  string,

  /**
   * latest
   */
  latest: "latest",
}

/**
 * The compliance state that should be set on the resource.
 */
union ComplianceState {
  string,

  /**
   * The resource is in compliance with the policy.
   */
  Compliant: "Compliant",

  /**
   * The resource is not in compliance with the policy.
   */
  NonCompliant: "NonCompliant",

  /**
   * The compliance state of the resource is not known.
   */
  Unknown: "Unknown",
}

/**
 * List of attestations.
 */
model AttestationListResult is Azure.Core.Page<Attestation>;

/**
 * List of remediations.
 */
model RemediationListResult is Azure.Core.Page<Remediation>;

/**
 * List of deployments for a remediation.
 */
model RemediationDeploymentsListResult
  is Azure.Core.Page<RemediationDeployment>;

/**
 * Details of a single deployment created by the remediation.
 */
model RemediationDeployment {
  /**
   * Resource ID of the resource that is being remediated by the deployment.
   */
  @visibility(Lifecycle.Read)
  remediatedResourceId?: string;

  /**
   * Resource ID of the template deployment that will remediate the resource.
   */
  @visibility(Lifecycle.Read)
  deploymentId?: string;

  /**
   * Status of the remediation deployment.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Location of the resource that is being remediated.
   */
  @visibility(Lifecycle.Read)
  resourceLocation?: string;

  /**
   * Error encountered while remediated the resource.
   */
  @visibility(Lifecycle.Read)
  error?: ErrorDefinition;

  /**
   * The time at which the remediation was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The time at which the remediation deployment was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Description of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The target of the error.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * Internal error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: ErrorDefinition[];

  /**
   * Additional scenario specific error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: TypedErrorInfo[];
}

/**
 * Scenario specific error details.
 */
model TypedErrorInfo {
  /**
   * The type of included error details.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The scenario specific error details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * Error response.
 */
@error
model ErrorResponse {
  /**
   * The error details.
   */
  error?: ErrorDefinition;
}

/**
 * The remediation properties.
 */
model RemediationProperties {
  /**
   * The resource ID of the policy assignment that should be remediated.
   */
  policyAssignmentId?: string;

  /**
   * The policy definition reference ID of the individual definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition.
   */
  policyDefinitionReferenceId?: string;

  /**
   * The way resources to remediate are discovered. Defaults to ExistingNonCompliant if not specified.
   */
  resourceDiscoveryMode?: ResourceDiscoveryMode;

  /**
   * The status of the remediation. This refers to the entire remediation task, not individual deployments. Allowed values are Evaluating, Canceled, Cancelling, Failed, Complete, or Succeeded.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The time at which the remediation was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The time at which the remediation was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * The filters that will be applied to determine which resources to remediate.
   */
  filters?: RemediationFilters;

  /**
   * The deployment status summary for all deployments created by the remediation.
   */
  @visibility(Lifecycle.Read)
  deploymentStatus?: RemediationDeploymentSummary;

  /**
   * The remediation status message. Provides additional details regarding the state of the remediation.
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * The remediation correlation Id. Can be used to find events related to the remediation in the activity log.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * Determines the max number of resources that can be remediated by the remediation job. If not provided, the default resource count is used.
   */
  resourceCount?: int32;

  /**
   * Determines how many resources to remediate at any given time. Can be used to increase or reduce the pace of the remediation. If not provided, the default parallel deployments value is used.
   */
  parallelDeployments?: int32;

  /**
   * The remediation failure threshold settings
   */
  failureThreshold?: RemediationPropertiesFailureThreshold;
}

/**
 * The filters that will be applied to determine which resources to remediate.
 */
model RemediationFilters {
  /**
   * The resource locations that will be remediated.
   */
  locations?: string[];

  /**
   * The IDs of the resources that will be remediated. Can specify at most 100 IDs. This filter cannot be used when ReEvaluateCompliance is set to ReEvaluateCompliance, and cannot be empty if provided.
   */
  resourceIds?: string[];
}

/**
 * The deployment status summary for all deployments created by the remediation.
 */
model RemediationDeploymentSummary {
  /**
   * The number of deployments required by the remediation.
   */
  @visibility(Lifecycle.Read)
  totalDeployments?: int32;

  /**
   * The number of deployments required by the remediation that have succeeded.
   */
  @visibility(Lifecycle.Read)
  successfulDeployments?: int32;

  /**
   * The number of deployments required by the remediation that have failed.
   */
  @visibility(Lifecycle.Read)
  failedDeployments?: int32;
}

/**
 * The remediation failure threshold settings
 */
model RemediationPropertiesFailureThreshold {
  /**
   * A number between 0.0 to 1.0 representing the percentage failure threshold. The remediation will fail if the percentage of failed remediation operations (i.e. failed deployments) exceeds this threshold.
   */
  percentage?: float32;
}

/**
 * Query results.
 */
model PolicyEventsQueryResults {
  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.context`?: string;

  /**
   * OData entity count; represents the number of policy event records returned.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(0)
  `@odata.count`?: int32;

  /**
   * Odata next link; URL to get the next set of results.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  `@odata.nextLink`?: string;

  /**
   * Query results.
   */
  @pageItems
  @identifiers(#[])
  value?: PolicyEvent[];
}

/**
 * Policy event record.
 */
model PolicyEvent {
  ...Record<unknown>;

  /**
   * OData entity ID; always set to null since policy event records do not have an entity ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.id`?: string;

  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.context`?: string;

  /**
   * Timestamp for the policy event record.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Resource ID.
   */
  resourceId?: string;

  /**
   * Policy assignment ID.
   */
  policyAssignmentId?: string;

  /**
   * Policy definition ID.
   */
  policyDefinitionId?: string;

  /**
   * Effective parameters for the policy assignment.
   */
  effectiveParameters?: string;

  /**
   * Flag which states whether the resource is compliant against the policy assignment it was evaluated against.
   */
  isCompliant?: boolean;

  /**
   * Subscription ID.
   */
  subscriptionId?: string;

  /**
   * Resource type.
   */
  resourceType?: string;

  /**
   * Resource location.
   */
  resourceLocation?: string;

  /**
   * Resource group name.
   */
  resourceGroup?: string;

  /**
   * List of resource tags.
   */
  resourceTags?: string;

  /**
   * Policy assignment name.
   */
  policyAssignmentName?: string;

  /**
   * Policy assignment owner.
   */
  policyAssignmentOwner?: string;

  /**
   * Policy assignment parameters.
   */
  policyAssignmentParameters?: string;

  /**
   * Policy assignment scope.
   */
  policyAssignmentScope?: string;

  /**
   * Policy definition name.
   */
  policyDefinitionName?: string;

  /**
   * Policy definition action, i.e. effect.
   */
  policyDefinitionAction?: string;

  /**
   * Policy definition category.
   */
  policyDefinitionCategory?: string;

  /**
   * Policy set definition ID, if the policy assignment is for a policy set.
   */
  policySetDefinitionId?: string;

  /**
   * Policy set definition name, if the policy assignment is for a policy set.
   */
  policySetDefinitionName?: string;

  /**
   * Policy set definition owner, if the policy assignment is for a policy set.
   */
  policySetDefinitionOwner?: string;

  /**
   * Policy set definition category, if the policy assignment is for a policy set.
   */
  policySetDefinitionCategory?: string;

  /**
   * Policy set definition parameters, if the policy assignment is for a policy set.
   */
  policySetDefinitionParameters?: string;

  /**
   * Comma separated list of management group IDs, which represent the hierarchy of the management groups the resource is under.
   */
  managementGroupIds?: string;

  /**
   * Reference ID for the policy definition inside the policy set, if the policy assignment is for a policy set.
   */
  policyDefinitionReferenceId?: string;

  /**
   * Compliance state of the resource.
   */
  complianceState?: string;

  /**
   * Tenant ID for the policy event record.
   */
  tenantId?: string;

  /**
   * Principal object ID for the user who initiated the resource operation that triggered the policy event.
   */
  principalOid?: string;

  /**
   * Components events records populated only when URL contains $expand=components clause.
   */
  components?: ComponentEventDetails[];
}

/**
 * Component event details.
 */
model ComponentEventDetails {
  ...Record<unknown>;

  /**
   * Component Id.
   */
  id?: string;

  /**
   * Component type.
   */
  type?: string;

  /**
   * Component name.
   */
  name?: string;

  /**
   * Timestamp for component policy event record.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Tenant ID for the policy event record.
   */
  tenantId?: string;

  /**
   * Principal object ID for the user who initiated the resource component operation that triggered the policy event.
   */
  principalOid?: string;

  /**
   * Policy definition action, i.e. effect.
   */
  policyDefinitionAction?: string;
}

/**
 * Query results.
 */
model PolicyStatesQueryResults {
  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.context`?: string;

  /**
   * OData entity count; represents the number of policy state records returned.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(0)
  `@odata.count`?: int32;

  /**
   * Odata next link; URL to get the next set of results.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  `@odata.nextLink`?: string;

  /**
   * Query results.
   */
  @pageItems
  @identifiers(#[])
  value?: PolicyState[];
}

/**
 * Policy state record.
 */
model PolicyState {
  ...Record<unknown>;

  /**
   * OData entity ID; always set to null since policy state records do not have an entity ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.id`?: string;

  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.context`?: string;

  /**
   * Timestamp for the policy state record.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Resource ID.
   */
  resourceId?: string;

  /**
   * Policy assignment ID.
   */
  policyAssignmentId?: string;

  /**
   * Policy definition ID.
   */
  policyDefinitionId?: string;

  /**
   * Effective parameters for the policy assignment.
   */
  effectiveParameters?: string;

  /**
   * Flag which states whether the resource is compliant against the policy assignment it was evaluated against. This property is deprecated; please use ComplianceState instead.
   */
  isCompliant?: boolean;

  /**
   * Subscription ID.
   */
  subscriptionId?: string;

  /**
   * Resource type.
   */
  resourceType?: string;

  /**
   * Resource location.
   */
  resourceLocation?: string;

  /**
   * Resource group name.
   */
  resourceGroup?: string;

  /**
   * List of resource tags.
   */
  resourceTags?: string;

  /**
   * Policy assignment name.
   */
  policyAssignmentName?: string;

  /**
   * Policy assignment owner.
   */
  policyAssignmentOwner?: string;

  /**
   * Policy assignment parameters.
   */
  policyAssignmentParameters?: string;

  /**
   * Policy assignment scope.
   */
  policyAssignmentScope?: string;

  /**
   * Policy definition name.
   */
  policyDefinitionName?: string;

  /**
   * Policy definition action, i.e. effect.
   */
  policyDefinitionAction?: string;

  /**
   * Policy definition category.
   */
  policyDefinitionCategory?: string;

  /**
   * Policy set definition ID, if the policy assignment is for a policy set.
   */
  policySetDefinitionId?: string;

  /**
   * Policy set definition name, if the policy assignment is for a policy set.
   */
  policySetDefinitionName?: string;

  /**
   * Policy set definition owner, if the policy assignment is for a policy set.
   */
  policySetDefinitionOwner?: string;

  /**
   * Policy set definition category, if the policy assignment is for a policy set.
   */
  policySetDefinitionCategory?: string;

  /**
   * Policy set definition parameters, if the policy assignment is for a policy set.
   */
  policySetDefinitionParameters?: string;

  /**
   * Comma separated list of management group IDs, which represent the hierarchy of the management groups the resource is under.
   */
  managementGroupIds?: string;

  /**
   * Reference ID for the policy definition inside the policy set, if the policy assignment is for a policy set.
   */
  policyDefinitionReferenceId?: string;

  /**
   * Compliance state of the resource.
   */
  complianceState?: string;

  /**
   * Policy evaluation details.
   */
  policyEvaluationDetails?: PolicyEvaluationDetails;

  /**
   * Policy definition group names.
   */
  policyDefinitionGroupNames?: string[];

  /**
   * Components state compliance records populated only when URL contains $expand=components clause.
   */
  components?: ComponentStateDetails[];

  /**
   * Evaluated policy definition version.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionVersion?: string;

  /**
   * Evaluated policy set definition version.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionVersion?: string;

  /**
   * Evaluated policy assignment version.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentVersion?: string;
}

/**
 * Policy evaluation details.
 */
model PolicyEvaluationDetails {
  /**
   * Details of the evaluated expressions.
   */
  @identifiers(#[])
  evaluatedExpressions?: ExpressionEvaluationDetails[];

  /**
   * Evaluation details of IfNotExists effect.
   */
  ifNotExistsDetails?: IfNotExistsEvaluationDetails;
}

/**
 * Evaluation details of policy language expressions.
 */
model ExpressionEvaluationDetails {
  /**
   * Evaluation result.
   */
  result?: string;

  /**
   * Expression evaluated.
   */
  expression?: string;

  /**
   * The kind of expression that was evaluated.
   */
  @visibility(Lifecycle.Read)
  expressionKind?: string;

  /**
   * Property path if the expression is a field or an alias.
   */
  path?: string;

  /**
   * Value of the expression.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expressionValue?: unknown;

  /**
   * Target value to be compared with the expression value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetValue?: unknown;

  /**
   * Operator to compare the expression value and the target value.
   */
  operator?: string;
}

/**
 * Evaluation details of IfNotExists effect.
 */
model IfNotExistsEvaluationDetails {
  /**
   * ID of the last evaluated resource for IfNotExists effect.
   */
  resourceId?: string;

  /**
   * Total number of resources to which the existence condition is applicable.
   */
  totalResources?: int32;
}

/**
 * Component state details.
 */
model ComponentStateDetails {
  ...Record<unknown>;

  /**
   * Component Id.
   */
  id?: string;

  /**
   * Component type.
   */
  type?: string;

  /**
   * Component name.
   */
  name?: string;

  /**
   * Component compliance evaluation timestamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Component compliance state.
   */
  complianceState?: string;
}

/**
 * Summarize action results.
 */
model SummarizeResults {
  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.context`?: string;

  /**
   * OData entity count; represents the number of summaries returned; always set to 1.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(1)
  @minValue(1)
  `@odata.count`?: int32;

  /**
   * Summarize action results.
   */
  @identifiers(#[])
  value?: Summary[];
}

/**
 * Summary results.
 */
model Summary {
  /**
   * OData entity ID; always set to null since summaries do not have an entity ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.id`?: string;

  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.context`?: string;

  /**
   * Compliance summary for all policy assignments.
   */
  results?: SummaryResults;

  /**
   * Policy assignments summary.
   */
  @identifiers(#["policyAssignmentId"])
  policyAssignments?: PolicyAssignmentSummary[];
}

/**
 * Compliance summary on a particular summary level.
 */
model SummaryResults {
  /**
   * HTTP POST URI for queryResults action on Microsoft.PolicyInsights to retrieve raw results for the compliance summary. This property will not be available by default in future API versions, but could be queried explicitly.
   */
  queryResultsUri?: string;

  /**
   * Number of non-compliant resources.
   */
  @minValue(0)
  nonCompliantResources?: int32;

  /**
   * Number of non-compliant policies.
   */
  @minValue(0)
  nonCompliantPolicies?: int32;

  /**
   * The resources summary at this level.
   */
  @identifiers(#[])
  resourceDetails?: ComplianceDetail[];

  /**
   * The policy artifact summary at this level. For query scope level, it represents policy assignment summary. For policy assignment level, it represents policy definitions summary.
   */
  @identifiers(#[])
  policyDetails?: ComplianceDetail[];

  /**
   * The policy definition group summary at this level.
   */
  @identifiers(#[])
  policyGroupDetails?: ComplianceDetail[];
}

/**
 * The compliance state rollup.
 */
model ComplianceDetail {
  /**
   * The compliance state.
   */
  complianceState?: string;

  /**
   * Summarized count value for this compliance state.
   */
  count?: int32;
}

/**
 * Policy assignment summary.
 */
model PolicyAssignmentSummary {
  /**
   * Policy assignment ID.
   */
  policyAssignmentId?: string;

  /**
   * Policy set definition ID, if the policy assignment is for a policy set.
   */
  policySetDefinitionId?: string;

  /**
   * Compliance summary for the policy assignment.
   */
  results?: SummaryResults;

  /**
   * Policy definitions summary.
   */
  @identifiers(#["policyDefinitionId"])
  policyDefinitions?: PolicyDefinitionSummary[];

  /**
   * Policy definition group summary.
   */
  @identifiers(#["policyGroupName"])
  policyGroups?: PolicyGroupSummary[];
}

/**
 * Policy definition summary.
 */
model PolicyDefinitionSummary {
  /**
   * Policy definition ID.
   */
  policyDefinitionId?: string;

  /**
   * Policy definition reference ID.
   */
  policyDefinitionReferenceId?: string;

  /**
   * Policy definition group names.
   */
  policyDefinitionGroupNames?: string[];

  /**
   * Policy effect, i.e. policy definition action.
   */
  effect?: string;

  /**
   * Compliance summary for the policy definition.
   */
  results?: SummaryResults;
}

/**
 * Policy definition group summary.
 */
model PolicyGroupSummary {
  /**
   * Policy group name.
   */
  policyGroupName?: string;

  /**
   * Compliance summary for the policy definition group.
   */
  results?: SummaryResults;
}

/**
 * The properties of the policy metadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyMetadataProperties extends PolicyMetadataSlimProperties {
  /**
   * The description of the policy metadata.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The requirements of the policy metadata.
   */
  @visibility(Lifecycle.Read)
  requirements?: string;
}

/**
 * The properties of the policy metadata, excluding properties containing large strings
 */
model PolicyMetadataSlimProperties {
  /**
   * The policy metadata identifier.
   */
  @visibility(Lifecycle.Read)
  metadataId?: string;

  /**
   * The category of the policy metadata.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * The title of the policy metadata.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * The owner of the policy metadata.
   */
  @visibility(Lifecycle.Read)
  owner?: string;

  /**
   * Url for getting additional content about the resource metadata.
   */
  @visibility(Lifecycle.Read)
  additionalContentUrl?: string;

  /**
   * Additional metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  metadata?: unknown;
}

/**
 * Collection of policy metadata resources.
 */
model PolicyMetadataCollection is Azure.Core.Page<SlimPolicyMetadata>;

/**
 * Slim version of policy metadata resource definition, excluding properties with large strings
 */
model SlimPolicyMetadata {
  /**
   * Properties of the policy metadata.
   */
  properties?: PolicyMetadataSlimProperties;

  /**
   * The ID of the policy metadata.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the policy metadata.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the policy metadata.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * The check policy restrictions parameters describing the resource that is being evaluated.
 */
model CheckRestrictionsRequest {
  /**
   * The information about the resource that will be evaluated.
   */
  resourceDetails: CheckRestrictionsResourceDetails;

  /**
   * The list of fields and values that should be evaluated for potential restrictions.
   */
  @identifiers(#[])
  pendingFields?: PendingField[];

  /**
   * Whether to include policies with the 'audit' effect in the results. Defaults to false.
   */
  includeAuditEffect?: boolean = false;
}

/**
 * The information about the resource that will be evaluated.
 */
model CheckRestrictionsResourceDetails {
  /**
   * The resource content. This should include whatever properties are already known and can be a partial set of all resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceContent: unknown;

  /**
   * The api-version of the resource content.
   */
  apiVersion?: string;

  /**
   * The scope where the resource is being created. For example, if the resource is a child resource this would be the parent resource's resource ID.
   */
  scope?: string;
}

/**
 * A field that should be evaluated against Azure Policy to determine restrictions.
 */
model PendingField {
  /**
   * The name of the field. This can be a top-level property like 'name' or 'type' or an Azure Policy field alias.
   */
  field: string;

  /**
   * The list of potential values for the field that should be evaluated against Azure Policy.
   */
  values?: string[];
}

/**
 * The result of a check policy restrictions evaluation on a resource.
 */
model CheckRestrictionsResult {
  /**
   * The restrictions that will be placed on various fields in the resource by policy.
   */
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  fieldRestrictions?: FieldRestrictions[];

  /**
   * Evaluation results for the provided partial resource content.
   */
  @visibility(Lifecycle.Read)
  contentEvaluationResult?: CheckRestrictionsResultContentEvaluationResult;
}

/**
 * The restrictions that will be placed on a field in the resource by policy.
 */
model FieldRestrictions {
  /**
   * The name of the field. This can be a top-level property like 'name' or 'type' or an Azure Policy field alias.
   */
  @visibility(Lifecycle.Read)
  field?: string;

  /**
   * The restrictions placed on that field by policy.
   */
  @identifiers(#[])
  restrictions?: FieldRestriction[];
}

/**
 * The restrictions on a field imposed by a specific policy.
 */
model FieldRestriction {
  /**
   * The type of restriction that is imposed on the field.
   */
  @visibility(Lifecycle.Read)
  result?: FieldRestrictionResult;

  /**
   * The value that policy will set for the field if the user does not provide a value.
   */
  @visibility(Lifecycle.Read)
  defaultValue?: string;

  /**
   * The values that policy either requires or denies for the field.
   */
  @visibility(Lifecycle.Read)
  values?: string[];

  /**
   * The details of the policy that is causing the field restriction.
   */
  @visibility(Lifecycle.Read)
  policy?: PolicyReference;

  /**
   * The effect of the policy that is causing the field restriction. http://aka.ms/policyeffects
   */
  @visibility(Lifecycle.Read)
  policyEffect?: string;

  /**
   * The reason for the restriction.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}

/**
 * Resource identifiers for a policy.
 */
model PolicyReference {
  /**
   * The resource identifier of the policy definition.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionId?: string;

  /**
   * The resource identifier of the policy set definition.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionId?: string;

  /**
   * The reference identifier of a specific policy definition within a policy set definition.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionReferenceId?: string;

  /**
   * The resource identifier of the policy assignment.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentId?: string;
}

/**
 * Evaluation results for the provided partial resource content.
 */
model CheckRestrictionsResultContentEvaluationResult {
  /**
   * Policy evaluation results against the given resource content. This will indicate if the partial content that was provided will be denied as-is.
   */
  @identifiers(#[])
  policyEvaluations?: PolicyEvaluationResult[];
}

/**
 * The result of a non-compliant policy evaluation against the given resource content.
 */
model PolicyEvaluationResult {
  /**
   * The details of the policy that was evaluated.
   */
  @visibility(Lifecycle.Read)
  policyInfo?: PolicyReference;

  /**
   * The result of the policy evaluation against the resource. This will typically be 'NonCompliant' but may contain other values if errors were encountered.
   */
  @visibility(Lifecycle.Read)
  evaluationResult?: string;

  /**
   * The detailed results of the policy expressions and values that were evaluated.
   */
  @visibility(Lifecycle.Read)
  evaluationDetails?: CheckRestrictionEvaluationDetails;

  /**
   * The details of the effect that was applied to the resource.
   */
  @visibility(Lifecycle.Read)
  effectDetails?: PolicyEffectDetails;
}

/**
 * Policy evaluation details.
 */
model CheckRestrictionEvaluationDetails {
  /**
   * Details of the evaluated expressions.
   */
  @identifiers(#[])
  evaluatedExpressions?: ExpressionEvaluationDetails[];

  /**
   * Evaluation details of IfNotExists effect.
   */
  ifNotExistsDetails?: IfNotExistsEvaluationDetails;

  /**
   * The reason for the evaluation result.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}

/**
 * The details of the effect that was applied to the resource.
 */
model PolicyEffectDetails {
  /**
   * The effect that was applied to the resource. http://aka.ms/policyeffects
   */
  @visibility(Lifecycle.Read)
  policyEffect?: string;
}

/**
 * The check policy restrictions parameters describing the resource that is being evaluated.
 */
model CheckManagementGroupRestrictionsRequest {
  /**
   * The information about the resource that will be evaluated.
   */
  resourceDetails?: CheckRestrictionsResourceDetails;

  /**
   * The list of fields and values that should be evaluated for potential restrictions.
   */
  @identifiers(#[])
  pendingFields?: PendingField[];
}

/**
 * Query results.
 */
model ComponentPolicyStatesQueryResults {
  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.context`?: string;

  /**
   * OData entity count; represents the number of policy state records returned.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(0)
  `@odata.count`?: int32;

  /**
   * Query results.
   */
  @identifiers(#[])
  value?: ComponentPolicyState[];
}

/**
 * Component Policy State record.
 */
model ComponentPolicyState {
  ...Record<unknown>;

  /**
   * OData entity ID; always set to null since component policy state records do not have an entity ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  `@odata.id`?: string;

  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  `@odata.context`?: string;

  /**
   * Timestamp for the component policy state record.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Component Id.
   */
  @visibility(Lifecycle.Read)
  componentId?: string;

  /**
   * Component type.
   */
  @visibility(Lifecycle.Read)
  componentType?: string;

  /**
   * Component name.
   */
  @visibility(Lifecycle.Read)
  componentName?: string;

  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * Policy assignment ID.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentId?: string;

  /**
   * Policy definition ID.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionId?: string;

  /**
   * Subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * Resource location.
   */
  @visibility(Lifecycle.Read)
  resourceLocation?: string;

  /**
   * Resource group name.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * Policy assignment name.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentName?: string;

  /**
   * Policy assignment owner.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentOwner?: string;

  /**
   * Policy assignment parameters.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentParameters?: string;

  /**
   * Policy assignment scope.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentScope?: string;

  /**
   * Policy definition name.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionName?: string;

  /**
   * Policy definition action, i.e. effect.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionAction?: string;

  /**
   * Policy definition category.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionCategory?: string;

  /**
   * Policy set definition ID, if the policy assignment is for a policy set.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionId?: string;

  /**
   * Policy set definition name, if the policy assignment is for a policy set.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionName?: string;

  /**
   * Policy set definition owner, if the policy assignment is for a policy set.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionOwner?: string;

  /**
   * Policy set definition category, if the policy assignment is for a policy set.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionCategory?: string;

  /**
   * Policy set definition parameters, if the policy assignment is for a policy set.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionParameters?: string;

  /**
   * Reference ID for the policy definition inside the policy set, if the policy assignment is for a policy set.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionReferenceId?: string;

  /**
   * Compliance state of the resource.
   */
  @visibility(Lifecycle.Read)
  complianceState?: string;

  /**
   * Policy evaluation details. This is only included in the response if the request contains $expand=PolicyEvaluationDetails.
   */
  policyEvaluationDetails?: ComponentPolicyEvaluationDetails;

  /**
   * Policy definition group names.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionGroupNames?: string[];

  /**
   * Evaluated policy definition version.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionVersion?: string;

  /**
   * Evaluated policy set definition version.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionVersion?: string;

  /**
   * Evaluated policy assignment version.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentVersion?: string;
}

/**
 * Policy evaluation details.
 */
model ComponentPolicyEvaluationDetails {
  /**
   * Details of the evaluated expressions.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  evaluatedExpressions?: ComponentExpressionEvaluationDetails[];

  /**
   * Additional textual reason for the evaluation outcome.
   */
  reason?: string;
}

/**
 * Evaluation details of policy language expressions.
 */
model ComponentExpressionEvaluationDetails {
  /**
   * Evaluation result.
   */
  result?: string;

  /**
   * Expression evaluated.
   */
  @visibility(Lifecycle.Read)
  expression?: string;

  /**
   * The kind of expression that was evaluated.
   */
  @visibility(Lifecycle.Read)
  expressionKind?: string;

  /**
   * Property path if the expression is a field or an alias.
   */
  @visibility(Lifecycle.Read)
  path?: string;

  /**
   * Value of the expression.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  expressionValue?: unknown;

  /**
   * Target value to be compared with the expression value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  targetValue?: unknown;

  /**
   * Operator to compare the expression value and the target value.
   */
  @visibility(Lifecycle.Read)
  operator?: string;
}

/**
 * Operation definition.
 */
model Operation {
  /**
   * Operation name.
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display metadata associated with the operation.
   */
  display?: OperationDisplay;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Resource provider name.
   */
  provider?: string;

  /**
   * Resource name on which the operation is performed.
   */
  resource?: string;

  /**
   * Operation name.
   */
  operation?: string;

  /**
   * Operation description.
   */
  description?: string;
}

/**
 * The properties of an attestation resource.
 */
model AttestationProperties {
  /**
   * The resource ID of the policy assignment that the attestation is setting the state for.
   */
  policyAssignmentId: string;

  /**
   * The policy definition reference ID from a policy set definition that the attestation is setting the state for. If the policy assignment assigns a policy set definition the attestation can choose a definition within the set definition with this property or omit this and set the state for the entire set definition.
   */
  policyDefinitionReferenceId?: string;

  /**
   * The compliance state that should be set on the resource.
   */
  complianceState?: ComplianceState;

  /**
   * The time the compliance state should expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresOn?: utcDateTime;

  /**
   * The person responsible for setting the state of the resource. This value is typically an Azure Active Directory object ID.
   */
  owner?: string;

  /**
   * Comments describing why this attestation was created.
   */
  comments?: string;

  /**
   * The evidence supporting the compliance state set in this attestation.
   */
  @identifiers(#[])
  evidence?: AttestationEvidence[];

  /**
   * The status of the attestation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The time the compliance state was last changed in this attestation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastComplianceStateChangeAt?: utcDateTime;

  /**
   * The time the evidence was assessed
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assessmentDate?: utcDateTime;

  /**
   * Additional metadata for this attestation
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: unknown;
}

/**
 * A piece of evidence supporting the compliance state set in the attestation.
 */
model AttestationEvidence {
  /**
   * The description for this piece of evidence.
   */
  description?: string;

  /**
   * The URI location of the evidence.
   */
  sourceUri?: string;
}
