import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.PolicyInsights;

interface Operations extends Azure.ResourceManager.Operations {}

enum PolicyTrackedResourcesResourceType {
  default,
}

/**
 * The way resources to remediate are discovered. Defaults to ExistingNonCompliant if not specified.
 */
enum ResourceDiscoveryMode {
  /**
   * Remediate resources that are already known to be non-compliant.
   */
  ExistingNonCompliant,

  /**
   * Re-evaluate the compliance state of resources and then remediate the resources found to be non-compliant.
   */
  ReEvaluateCompliance,
}

enum PolicyEventsResourceType {
  default,
}

enum PolicyStatesResource {
  default,
  latest,
}

enum PolicyStatesSummaryResourceType {
  latest,
}

/**
 * The type of restriction that is imposed on the field.
 */
enum FieldRestrictionResult {
  /**
   * The field and/or values are required by policy.
   */
  Required,

  /**
   * The field will be removed by policy.
   */
  Removed,

  /**
   * The field and/or values will be denied by policy.
   */
  Deny,
}

/**
 * The compliance state that should be set on the resource.
 */
enum ComplianceState {
  /**
   * The resource is in compliance with the policy.
   */
  Compliant,

  /**
   * The resource is not in compliance with the policy.
   */
  NonCompliant,

  /**
   * The compliance state of the resource is not known.
   */
  Unknown,
}

/**
 * Query results.
 */
model PolicyTrackedResourcesQueryResults
  is Azure.Core.Page<PolicyTrackedResource>;

/**
 * Policy tracked resource record.
 */
model PolicyTrackedResource {
  /**
   * The ID of the policy tracked resource.
   */
  @visibility("read")
  trackedResourceId?: string;

  /**
   * The details of the policy that require the tracked resource.
   */
  @visibility("read")
  policyDetails?: PolicyDetails;

  /**
   * The details of the policy triggered deployment that created the tracked resource.
   */
  @visibility("read")
  createdBy?: TrackedResourceModificationDetails;

  /**
   * The details of the policy triggered deployment that modified the tracked resource.
   */
  @visibility("read")
  lastModifiedBy?: TrackedResourceModificationDetails;

  /**
   * Timestamp of the last update to the tracked resource.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateUtc?: utcDateTime;
}

/**
 * The policy details.
 */
model PolicyDetails {
  /**
   * The ID of the policy definition.
   */
  @visibility("read")
  policyDefinitionId?: string;

  /**
   * The ID of the policy assignment.
   */
  @visibility("read")
  policyAssignmentId?: string;

  /**
   * The display name of the policy assignment.
   */
  @visibility("read")
  policyAssignmentDisplayName?: string;

  /**
   * The scope of the policy assignment.
   */
  @visibility("read")
  policyAssignmentScope?: string;

  /**
   * The ID of the policy set definition.
   */
  @visibility("read")
  policySetDefinitionId?: string;

  /**
   * The policy definition reference ID within the policy set definition.
   */
  @visibility("read")
  policyDefinitionReferenceId?: string;
}

/**
 * The details of the policy triggered deployment that created or modified the tracked resource.
 */
model TrackedResourceModificationDetails {
  /**
   * The details of the policy that created or modified the tracked resource.
   */
  @visibility("read")
  policyDetails?: PolicyDetails;

  /**
   * The ID of the deployment that created or modified the tracked resource.
   */
  @visibility("read")
  deploymentId?: string;

  /**
   * Timestamp of the deployment that created or modified the tracked resource.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deploymentTime?: utcDateTime;
}

/**
 * Error response.
 */
@error
model QueryFailure {
  /**
   * Error definition.
   */
  error?: QueryFailureError;
}

/**
 * Error definition.
 */
model QueryFailureError {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;
}

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
  @visibility("read")
  remediatedResourceId?: string;

  /**
   * Resource ID of the template deployment that will remediate the resource.
   */
  @visibility("read")
  deploymentId?: string;

  /**
   * Status of the remediation deployment.
   */
  @visibility("read")
  status?: string;

  /**
   * Location of the resource that is being remediated.
   */
  @visibility("read")
  resourceLocation?: string;

  /**
   * Error encountered while remediated the resource.
   */
  @visibility("read")
  error?: RemediationErrorDefinition;

  /**
   * The time at which the remediation was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The time at which the remediation deployment was last updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;
}

/**
 * Error definition.
 */
model RemediationErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * The target of the error.
   */
  @visibility("read")
  target?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  details?: RemediationErrorDefinition[];

  /**
   * Additional scenario specific error details.
   */
  @visibility("read")
  additionalInfo?: TypedErrorInfo[];
}

/**
 * Scenario specific error details.
 */
model TypedErrorInfo {
  /**
   * The type of included error details.
   */
  @visibility("read")
  type?: string;

  /**
   * The scenario specific error details.
   */
  @visibility("read")
  info?: unknown;
}

/**
 * Error response.
 */
@error
model RemediationErrorResponse {
  /**
   * The error details.
   */
  error?: RemediationErrorDefinition;
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
   * The status of the remediation.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The time at which the remediation was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The time at which the remediation was last updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * The filters that will be applied to determine which resources to remediate.
   */
  filters?: RemediationFilters;

  /**
   * The deployment status summary for all deployments created by the remediation.
   */
  @visibility("read")
  deploymentStatus?: RemediationDeploymentSummary;

  /**
   * The remediation status message. Provides additional details regarding the state of the remediation.
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * The remediation correlation Id. Can be used to find events related to the remediation in the activity log.
   */
  @visibility("read")
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
}

/**
 * The deployment status summary for all deployments created by the remediation.
 */
model RemediationDeploymentSummary {
  /**
   * The number of deployments required by the remediation.
   */
  @visibility("read")
  totalDeployments?: int32;

  /**
   * The number of deployments required by the remediation that have succeeded.
   */
  @visibility("read")
  successfulDeployments?: int32;

  /**
   * The number of deployments required by the remediation that have failed.
   */
  @visibility("read")
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
@pagedResult
model PolicyEventsQueryResults {
  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  /**
   * OData entity count; represents the number of policy event records returned.
   */
  @projectedName("json", "@odata.count")
  OdataCount?: int32;

  /**
   * Odata next link; URL to get the next set of results.
   */
  @nextLink
  @projectedName("json", "@odata.nextLink")
  OdataNextLink?: string;

  /**
   * Query results.
   */
  @items
  value?: PolicyEvent[];
}

/**
 * Policy event record.
 */
model PolicyEvent extends Record<unknown> {
  /**
   * OData entity ID; always set to null since policy event records do not have an entity ID.
   */
  @projectedName("json", "@odata.id")
  OdataId?: string;

  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  @projectedName("json", "@odata.context")
  OdataContext?: string;

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
model ComponentEventDetails extends Record<unknown> {
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
@pagedResult
model PolicyStatesQueryResults {
  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  /**
   * OData entity count; represents the number of policy state records returned.
   */
  @projectedName("json", "@odata.count")
  OdataCount?: int32;

  /**
   * Odata next link; URL to get the next set of results.
   */
  @nextLink
  @projectedName("json", "@odata.nextLink")
  OdataNextLink?: string;

  /**
   * Query results.
   */
  @items
  value?: PolicyState[];
}

/**
 * Policy state record.
 */
model PolicyState extends Record<unknown> {
  /**
   * OData entity ID; always set to null since policy state records do not have an entity ID.
   */
  @projectedName("json", "@odata.id")
  OdataId?: string;

  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  @projectedName("json", "@odata.context")
  OdataContext?: string;

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
  @visibility("read")
  policyDefinitionVersion?: string;

  /**
   * Evaluated policy set definition version.
   */
  @visibility("read")
  policySetDefinitionVersion?: string;

  /**
   * Evaluated policy assignment version.
   */
  @visibility("read")
  policyAssignmentVersion?: string;
}

/**
 * Policy evaluation details.
 */
model PolicyEvaluationDetails {
  /**
   * Details of the evaluated expressions.
   */
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
  @visibility("read")
  expressionKind?: string;

  /**
   * Property path if the expression is a field or an alias.
   */
  path?: string;

  /**
   * Value of the expression.
   */
  expressionValue?: Record<unknown>;

  /**
   * Target value to be compared with the expression value.
   */
  targetValue?: Record<unknown>;

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
model ComponentStateDetails extends Record<unknown> {
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
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  /**
   * OData entity count; represents the number of summaries returned; always set to 1.
   */
  @maxValue(1)
  @minValue(1)
  @projectedName("json", "@odata.count")
  OdataCount?: int32;

  /**
   * Summarize action results.
   */
  value?: Summary[];
}

/**
 * Summary results.
 */
model Summary {
  /**
   * OData entity ID; always set to null since summaries do not have an entity ID.
   */
  @projectedName("json", "@odata.id")
  OdataId?: string;

  /**
   * OData context string; used by OData clients to resolve type information based on metadata.
   */
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  /**
   * Compliance summary for all policy assignments.
   */
  results?: SummaryResults;

  /**
   * Policy assignments summary.
   */
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
  nonCompliantResources?: int32;

  /**
   * Number of non-compliant policies.
   */
  nonCompliantPolicies?: int32;

  /**
   * The resources summary at this level.
   */
  resourceDetails?: ComplianceDetail[];

  /**
   * The policy artifact summary at this level. For query scope level, it represents policy assignment summary. For policy assignment level, it represents policy definitions summary.
   */
  policyDetails?: ComplianceDetail[];

  /**
   * The policy definition group summary at this level.
   */
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
  policyDefinitions?: PolicyDefinitionSummary[];

  /**
   * Policy definition group summary.
   */
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
model PolicyMetadataProperties extends PolicyMetadataSlimProperties {
  /**
   * The description of the policy metadata.
   */
  @visibility("read")
  description?: string;

  /**
   * The requirements of the policy metadata.
   */
  @visibility("read")
  requirements?: string;
}

/**
 * The properties of the policy metadata, excluding properties containing large strings
 */
model PolicyMetadataSlimProperties {
  /**
   * The policy metadata identifier.
   */
  @visibility("read")
  metadataId?: string;

  /**
   * The category of the policy metadata.
   */
  @visibility("read")
  category?: string;

  /**
   * The title of the policy metadata.
   */
  @visibility("read")
  title?: string;

  /**
   * The owner of the policy metadata.
   */
  @visibility("read")
  owner?: string;

  /**
   * Url for getting additional content about the resource metadata.
   */
  @visibility("read")
  additionalContentUrl?: string;

  /**
   * Additional metadata.
   */
  @visibility("read")
  metadata?: Record<unknown>;
}

/**
 * Error response.
 */
@error
model PolicyMetadataErrorResponse {
  /**
   * The error details.
   */
  error?: PolicyMetadataErrorDefinition;
}

/**
 * Error definition.
 */
model PolicyMetadataErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * The target of the error.
   */
  @visibility("read")
  target?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  details?: PolicyMetadataErrorDefinition[];

  /**
   * Additional scenario specific error details.
   */
  @visibility("read")
  additionalInfo?: TypedErrorInfo[];
}

/**
 * Slim version of policy metadata resource definition, excluding properties with large strings
 */
model SlimPolicyMetadata {
  /**
   * Properties of the policy metadata.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PolicyMetadataSlimProperties;

  /**
   * The ID of the policy metadata.
   */
  @visibility("read")
  id?: string;

  /**
   * The type of the policy metadata.
   */
  @visibility("read")
  type?: string;

  /**
   * The name of the policy metadata.
   */
  @visibility("read")
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
  pendingFields?: PendingField[];
}

/**
 * The information about the resource that will be evaluated.
 */
model CheckRestrictionsResourceDetails {
  /**
   * The resource content. This should include whatever properties are already known and can be a partial set of all resource properties.
   */
  resourceContent: Record<unknown>;

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
  @visibility("read")
  fieldRestrictions?: FieldRestrictions[];

  /**
   * Evaluation results for the provided partial resource content.
   */
  @visibility("read")
  contentEvaluationResult?: CheckRestrictionsResultContentEvaluationResult;
}

/**
 * The restrictions that will be placed on a field in the resource by policy.
 */
model FieldRestrictions {
  /**
   * The name of the field. This can be a top-level property like 'name' or 'type' or an Azure Policy field alias.
   */
  @visibility("read")
  field?: string;

  /**
   * The restrictions placed on that field by policy.
   */
  restrictions?: FieldRestriction[];
}

/**
 * The restrictions on a field imposed by a specific policy.
 */
model FieldRestriction {
  /**
   * The type of restriction that is imposed on the field.
   */
  @visibility("read")
  result?: FieldRestrictionResult;

  /**
   * The value that policy will set for the field if the user does not provide a value.
   */
  @visibility("read")
  defaultValue?: string;

  /**
   * The values that policy either requires or denies for the field.
   */
  @visibility("read")
  values?: string[];

  /**
   * The details of the policy that is causing the field restriction.
   */
  @visibility("read")
  policy?: PolicyReference;
}

/**
 * Resource identifiers for a policy.
 */
model PolicyReference {
  /**
   * The resource identifier of the policy definition.
   */
  @visibility("read")
  policyDefinitionId?: string;

  /**
   * The resource identifier of the policy set definition.
   */
  @visibility("read")
  policySetDefinitionId?: string;

  /**
   * The reference identifier of a specific policy definition within a policy set definition.
   */
  @visibility("read")
  policyDefinitionReferenceId?: string;

  /**
   * The resource identifier of the policy assignment.
   */
  @visibility("read")
  policyAssignmentId?: string;
}

/**
 * Evaluation results for the provided partial resource content.
 */
model CheckRestrictionsResultContentEvaluationResult {
  /**
   * Policy evaluation results against the given resource content. This will indicate if the partial content that was provided will be denied as-is.
   */
  policyEvaluations?: PolicyEvaluationResult[];
}

/**
 * The result of a non-compliant policy evaluation against the given resource content.
 */
model PolicyEvaluationResult {
  /**
   * The details of the policy that was evaluated.
   */
  @visibility("read")
  policyInfo?: PolicyReference;

  /**
   * The result of the policy evaluation against the resource. This will typically be 'NonCompliant' but may contain other values if errors were encountered.
   */
  @visibility("read")
  evaluationResult?: string;

  /**
   * The detailed results of the policy expressions and values that were evaluated.
   */
  @visibility("read")
  evaluationDetails?: PolicyEvaluationDetails;
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
  pendingFields?: PendingField[];
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
  evidence?: AttestationEvidence[];

  /**
   * The status of the attestation.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The time the compliance state was last changed in this attestation.
   */
  @visibility("read")
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
  metadata?: Record<unknown>;
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

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * Error response.
 */
@error
model AttestationErrorResponse {
  /**
   * The error details.
   */
  error?: AttestationErrorDefinition;
}

/**
 * Error definition.
 */
model AttestationErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * The target of the error.
   */
  @visibility("read")
  target?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  details?: AttestationErrorDefinition[];

  /**
   * Additional scenario specific error details.
   */
  @visibility("read")
  additionalInfo?: TypedErrorInfo[];
}
