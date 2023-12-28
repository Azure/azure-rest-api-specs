import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.PolicyInsights;

interface Operations extends Azure.ResourceManager.Operations {}

enum PolicyTrackedResourcesResourceType {
  default,
}

enum ResourceDiscoveryMode {
  @doc("Remediate resources that are already known to be non-compliant.")
  ExistingNonCompliant,
  @doc("Re-evaluate the compliance state of resources and then remediate the resources found to be non-compliant.")
  ReEvaluateCompliance,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
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

enum FieldRestrictionResult {
  @doc("The field and/or values are required by policy.") Required,
  @doc("The field will be removed by policy.") Removed,
  @doc("The field and/or values will be denied by policy.") Deny,
}

enum ComplianceState {
  @doc("The resource is in compliance with the policy.") Compliant,
  @doc("The resource is not in compliance with the policy.") NonCompliant,
  @doc("The compliance state of the resource is not known.") Unknown,
}

@doc("Query results.")
model PolicyTrackedResourcesQueryResults
  is Azure.Core.Page<PolicyTrackedResource>;

@doc("Policy tracked resource record.")
model PolicyTrackedResource {
  @doc("The ID of the policy tracked resource.")
  @visibility("read")
  trackedResourceId?: string;

  @doc("The details of the policy that require the tracked resource.")
  @visibility("read")
  policyDetails?: PolicyDetails;

  @doc("The details of the policy triggered deployment that created the tracked resource.")
  @visibility("read")
  createdBy?: TrackedResourceModificationDetails;

  @doc("The details of the policy triggered deployment that modified the tracked resource.")
  @visibility("read")
  lastModifiedBy?: TrackedResourceModificationDetails;

  @doc("Timestamp of the last update to the tracked resource.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateUtc?: utcDateTime;
}

@doc("The policy details.")
model PolicyDetails {
  @doc("The ID of the policy definition.")
  @visibility("read")
  policyDefinitionId?: string;

  @doc("The ID of the policy assignment.")
  @visibility("read")
  policyAssignmentId?: string;

  @doc("The display name of the policy assignment.")
  @visibility("read")
  policyAssignmentDisplayName?: string;

  @doc("The scope of the policy assignment.")
  @visibility("read")
  policyAssignmentScope?: string;

  @doc("The ID of the policy set definition.")
  @visibility("read")
  policySetDefinitionId?: string;

  @doc("The policy definition reference ID within the policy set definition.")
  @visibility("read")
  policyDefinitionReferenceId?: string;
}

@doc("The details of the policy triggered deployment that created or modified the tracked resource.")
model TrackedResourceModificationDetails {
  @doc("The details of the policy that created or modified the tracked resource.")
  @visibility("read")
  policyDetails?: PolicyDetails;

  @doc("The ID of the deployment that created or modified the tracked resource.")
  @visibility("read")
  deploymentId?: string;

  @doc("Timestamp of the deployment that created or modified the tracked resource.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deploymentTime?: utcDateTime;
}

@doc("Error response.")
@error
model QueryFailure {
  @doc("Error definition.")
  error?: QueryFailureError;
}

@doc("Error definition.")
model QueryFailureError {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;
}

@doc("List of deployments for a remediation.")
model RemediationDeploymentsListResult
  is Azure.Core.Page<RemediationDeployment>;

@doc("Details of a single deployment created by the remediation.")
model RemediationDeployment {
  @doc("Resource ID of the resource that is being remediated by the deployment.")
  @visibility("read")
  remediatedResourceId?: string;

  @doc("Resource ID of the template deployment that will remediate the resource.")
  @visibility("read")
  deploymentId?: string;

  @doc("Status of the remediation deployment.")
  @visibility("read")
  status?: string;

  @doc("Location of the resource that is being remediated.")
  @visibility("read")
  resourceLocation?: string;

  @doc("Error encountered while remediated the resource.")
  @visibility("read")
  error?: RemediationErrorDefinition;

  @doc("The time at which the remediation was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("The time at which the remediation deployment was last updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;
}

@doc("Error definition.")
model RemediationErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("The target of the error.")
  @visibility("read")
  target?: string;

  @doc("Internal error details.")
  @visibility("read")
  details?: RemediationErrorDefinition[];

  @doc("Additional scenario specific error details.")
  @visibility("read")
  additionalInfo?: TypedErrorInfo[];
}

@doc("Scenario specific error details.")
model TypedErrorInfo {
  @doc("The type of included error details.")
  @visibility("read")
  type?: string;

  @doc("The scenario specific error details.")
  @visibility("read")
  info?: unknown;
}

@doc("Error response.")
@error
model RemediationErrorResponse {
  @doc("The error details.")
  error?: RemediationErrorDefinition;
}

@doc("The remediation properties.")
model RemediationProperties {
  @doc("The resource ID of the policy assignment that should be remediated.")
  policyAssignmentId?: string;

  @doc("The policy definition reference ID of the individual definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition.")
  policyDefinitionReferenceId?: string;

  @doc("The way resources to remediate are discovered. Defaults to ExistingNonCompliant if not specified.")
  resourceDiscoveryMode?: ResourceDiscoveryMode;

  @doc("The status of the remediation.")
  @visibility("read")
  provisioningState?: string;

  @doc("The time at which the remediation was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("The time at which the remediation was last updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("The filters that will be applied to determine which resources to remediate.")
  filters?: RemediationFilters;

  @doc("The deployment status summary for all deployments created by the remediation.")
  @visibility("read")
  deploymentStatus?: RemediationDeploymentSummary;

  @doc("The remediation status message. Provides additional details regarding the state of the remediation.")
  @visibility("read")
  statusMessage?: string;

  @doc("The remediation correlation Id. Can be used to find events related to the remediation in the activity log.")
  @visibility("read")
  correlationId?: string;

  @doc("Determines the max number of resources that can be remediated by the remediation job. If not provided, the default resource count is used.")
  resourceCount?: int32;

  @doc("Determines how many resources to remediate at any given time. Can be used to increase or reduce the pace of the remediation. If not provided, the default parallel deployments value is used.")
  parallelDeployments?: int32;

  @doc("The remediation failure threshold settings")
  failureThreshold?: RemediationPropertiesFailureThreshold;
}

@doc("The filters that will be applied to determine which resources to remediate.")
model RemediationFilters {
  @doc("The resource locations that will be remediated.")
  locations?: string[];
}

@doc("The deployment status summary for all deployments created by the remediation.")
model RemediationDeploymentSummary {
  @doc("The number of deployments required by the remediation.")
  @visibility("read")
  totalDeployments?: int32;

  @doc("The number of deployments required by the remediation that have succeeded.")
  @visibility("read")
  successfulDeployments?: int32;

  @doc("The number of deployments required by the remediation that have failed.")
  @visibility("read")
  failedDeployments?: int32;
}

@doc("The remediation failure threshold settings")
model RemediationPropertiesFailureThreshold {
  @doc("A number between 0.0 to 1.0 representing the percentage failure threshold. The remediation will fail if the percentage of failed remediation operations (i.e. failed deployments) exceeds this threshold.")
  percentage?: float32;
}

@doc("Query results.")
@pagedResult
model PolicyEventsQueryResults {
  @doc("OData context string; used by OData clients to resolve type information based on metadata.")
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  @doc("OData entity count; represents the number of policy event records returned.")
  @projectedName("json", "@odata.count")
  OdataCount?: int32;

  @doc("Odata next link; URL to get the next set of results.")
  @nextLink
  @projectedName("json", "@odata.nextLink")
  OdataNextLink?: string;

  @doc("Query results.")
  @items
  value?: PolicyEvent[];
}

@doc("Policy event record.")
model PolicyEvent extends Record<unknown> {
  @doc("OData entity ID; always set to null since policy event records do not have an entity ID.")
  @projectedName("json", "@odata.id")
  OdataId?: string;

  @doc("OData context string; used by OData clients to resolve type information based on metadata.")
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  @doc("Timestamp for the policy event record.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("Resource ID.")
  resourceId?: string;

  @doc("Policy assignment ID.")
  policyAssignmentId?: string;

  @doc("Policy definition ID.")
  policyDefinitionId?: string;

  @doc("Effective parameters for the policy assignment.")
  effectiveParameters?: string;

  @doc("Flag which states whether the resource is compliant against the policy assignment it was evaluated against.")
  isCompliant?: boolean;

  @doc("Subscription ID.")
  subscriptionId?: string;

  @doc("Resource type.")
  resourceType?: string;

  @doc("Resource location.")
  resourceLocation?: string;

  @doc("Resource group name.")
  resourceGroup?: string;

  @doc("List of resource tags.")
  resourceTags?: string;

  @doc("Policy assignment name.")
  policyAssignmentName?: string;

  @doc("Policy assignment owner.")
  policyAssignmentOwner?: string;

  @doc("Policy assignment parameters.")
  policyAssignmentParameters?: string;

  @doc("Policy assignment scope.")
  policyAssignmentScope?: string;

  @doc("Policy definition name.")
  policyDefinitionName?: string;

  @doc("Policy definition action, i.e. effect.")
  policyDefinitionAction?: string;

  @doc("Policy definition category.")
  policyDefinitionCategory?: string;

  @doc("Policy set definition ID, if the policy assignment is for a policy set.")
  policySetDefinitionId?: string;

  @doc("Policy set definition name, if the policy assignment is for a policy set.")
  policySetDefinitionName?: string;

  @doc("Policy set definition owner, if the policy assignment is for a policy set.")
  policySetDefinitionOwner?: string;

  @doc("Policy set definition category, if the policy assignment is for a policy set.")
  policySetDefinitionCategory?: string;

  @doc("Policy set definition parameters, if the policy assignment is for a policy set.")
  policySetDefinitionParameters?: string;

  @doc("Comma separated list of management group IDs, which represent the hierarchy of the management groups the resource is under.")
  managementGroupIds?: string;

  @doc("Reference ID for the policy definition inside the policy set, if the policy assignment is for a policy set.")
  policyDefinitionReferenceId?: string;

  @doc("Compliance state of the resource.")
  complianceState?: string;

  @doc("Tenant ID for the policy event record.")
  tenantId?: string;

  @doc("Principal object ID for the user who initiated the resource operation that triggered the policy event.")
  principalOid?: string;

  @doc("Components events records populated only when URL contains $expand=components clause.")
  components?: ComponentEventDetails[];
}

@doc("Component event details.")
model ComponentEventDetails extends Record<unknown> {
  @doc("Component Id.")
  id?: string;

  @doc("Component type.")
  type?: string;

  @doc("Component name.")
  name?: string;

  @doc("Timestamp for component policy event record.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("Tenant ID for the policy event record.")
  tenantId?: string;

  @doc("Principal object ID for the user who initiated the resource component operation that triggered the policy event.")
  principalOid?: string;

  @doc("Policy definition action, i.e. effect.")
  policyDefinitionAction?: string;
}

@doc("Query results.")
@pagedResult
model PolicyStatesQueryResults {
  @doc("OData context string; used by OData clients to resolve type information based on metadata.")
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  @doc("OData entity count; represents the number of policy state records returned.")
  @projectedName("json", "@odata.count")
  OdataCount?: int32;

  @doc("Odata next link; URL to get the next set of results.")
  @nextLink
  @projectedName("json", "@odata.nextLink")
  OdataNextLink?: string;

  @doc("Query results.")
  @items
  value?: PolicyState[];
}

@doc("Policy state record.")
model PolicyState extends Record<unknown> {
  @doc("OData entity ID; always set to null since policy state records do not have an entity ID.")
  @projectedName("json", "@odata.id")
  OdataId?: string;

  @doc("OData context string; used by OData clients to resolve type information based on metadata.")
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  @doc("Timestamp for the policy state record.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("Resource ID.")
  resourceId?: string;

  @doc("Policy assignment ID.")
  policyAssignmentId?: string;

  @doc("Policy definition ID.")
  policyDefinitionId?: string;

  @doc("Effective parameters for the policy assignment.")
  effectiveParameters?: string;

  @doc("Flag which states whether the resource is compliant against the policy assignment it was evaluated against. This property is deprecated; please use ComplianceState instead.")
  isCompliant?: boolean;

  @doc("Subscription ID.")
  subscriptionId?: string;

  @doc("Resource type.")
  resourceType?: string;

  @doc("Resource location.")
  resourceLocation?: string;

  @doc("Resource group name.")
  resourceGroup?: string;

  @doc("List of resource tags.")
  resourceTags?: string;

  @doc("Policy assignment name.")
  policyAssignmentName?: string;

  @doc("Policy assignment owner.")
  policyAssignmentOwner?: string;

  @doc("Policy assignment parameters.")
  policyAssignmentParameters?: string;

  @doc("Policy assignment scope.")
  policyAssignmentScope?: string;

  @doc("Policy definition name.")
  policyDefinitionName?: string;

  @doc("Policy definition action, i.e. effect.")
  policyDefinitionAction?: string;

  @doc("Policy definition category.")
  policyDefinitionCategory?: string;

  @doc("Policy set definition ID, if the policy assignment is for a policy set.")
  policySetDefinitionId?: string;

  @doc("Policy set definition name, if the policy assignment is for a policy set.")
  policySetDefinitionName?: string;

  @doc("Policy set definition owner, if the policy assignment is for a policy set.")
  policySetDefinitionOwner?: string;

  @doc("Policy set definition category, if the policy assignment is for a policy set.")
  policySetDefinitionCategory?: string;

  @doc("Policy set definition parameters, if the policy assignment is for a policy set.")
  policySetDefinitionParameters?: string;

  @doc("Comma separated list of management group IDs, which represent the hierarchy of the management groups the resource is under.")
  managementGroupIds?: string;

  @doc("Reference ID for the policy definition inside the policy set, if the policy assignment is for a policy set.")
  policyDefinitionReferenceId?: string;

  @doc("Compliance state of the resource.")
  complianceState?: string;

  @doc("Policy evaluation details.")
  policyEvaluationDetails?: PolicyEvaluationDetails;

  @doc("Policy definition group names.")
  policyDefinitionGroupNames?: string[];

  @doc("Components state compliance records populated only when URL contains $expand=components clause.")
  components?: ComponentStateDetails[];

  @doc("Evaluated policy definition version.")
  @visibility("read")
  policyDefinitionVersion?: string;

  @doc("Evaluated policy set definition version.")
  @visibility("read")
  policySetDefinitionVersion?: string;

  @doc("Evaluated policy assignment version.")
  @visibility("read")
  policyAssignmentVersion?: string;
}

@doc("Policy evaluation details.")
model PolicyEvaluationDetails {
  @doc("Details of the evaluated expressions.")
  evaluatedExpressions?: ExpressionEvaluationDetails[];

  @doc("Evaluation details of IfNotExists effect.")
  ifNotExistsDetails?: IfNotExistsEvaluationDetails;
}

@doc("Evaluation details of policy language expressions.")
model ExpressionEvaluationDetails {
  @doc("Evaluation result.")
  result?: string;

  @doc("Expression evaluated.")
  expression?: string;

  @doc("The kind of expression that was evaluated.")
  @visibility("read")
  expressionKind?: string;

  @doc("Property path if the expression is a field or an alias.")
  path?: string;

  @doc("Value of the expression.")
  expressionValue?: Record<unknown>;

  @doc("Target value to be compared with the expression value.")
  targetValue?: Record<unknown>;

  @doc("Operator to compare the expression value and the target value.")
  operator?: string;
}

@doc("Evaluation details of IfNotExists effect.")
model IfNotExistsEvaluationDetails {
  @doc("ID of the last evaluated resource for IfNotExists effect.")
  resourceId?: string;

  @doc("Total number of resources to which the existence condition is applicable.")
  totalResources?: int32;
}

@doc("Component state details.")
model ComponentStateDetails extends Record<unknown> {
  @doc("Component Id.")
  id?: string;

  @doc("Component type.")
  type?: string;

  @doc("Component name.")
  name?: string;

  @doc("Component compliance evaluation timestamp.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("Component compliance state.")
  complianceState?: string;
}

@doc("Summarize action results.")
model SummarizeResults {
  @doc("OData context string; used by OData clients to resolve type information based on metadata.")
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  @doc("OData entity count; represents the number of summaries returned; always set to 1.")
  @maxValue(1)
  @minValue(1)
  @projectedName("json", "@odata.count")
  OdataCount?: int32;

  @doc("Summarize action results.")
  value?: Summary[];
}

@doc("Summary results.")
model Summary {
  @doc("OData entity ID; always set to null since summaries do not have an entity ID.")
  @projectedName("json", "@odata.id")
  OdataId?: string;

  @doc("OData context string; used by OData clients to resolve type information based on metadata.")
  @projectedName("json", "@odata.context")
  OdataContext?: string;

  @doc("Compliance summary for all policy assignments.")
  results?: SummaryResults;

  @doc("Policy assignments summary.")
  policyAssignments?: PolicyAssignmentSummary[];
}

@doc("Compliance summary on a particular summary level.")
model SummaryResults {
  @doc("HTTP POST URI for queryResults action on Microsoft.PolicyInsights to retrieve raw results for the compliance summary. This property will not be available by default in future API versions, but could be queried explicitly.")
  queryResultsUri?: string;

  @doc("Number of non-compliant resources.")
  nonCompliantResources?: int32;

  @doc("Number of non-compliant policies.")
  nonCompliantPolicies?: int32;

  @doc("The resources summary at this level.")
  resourceDetails?: ComplianceDetail[];

  @doc("The policy artifact summary at this level. For query scope level, it represents policy assignment summary. For policy assignment level, it represents policy definitions summary.")
  policyDetails?: ComplianceDetail[];

  @doc("The policy definition group summary at this level.")
  policyGroupDetails?: ComplianceDetail[];
}

@doc("The compliance state rollup.")
model ComplianceDetail {
  @doc("The compliance state.")
  complianceState?: string;

  @doc("Summarized count value for this compliance state.")
  count?: int32;
}

@doc("Policy assignment summary.")
model PolicyAssignmentSummary {
  @doc("Policy assignment ID.")
  policyAssignmentId?: string;

  @doc("Policy set definition ID, if the policy assignment is for a policy set.")
  policySetDefinitionId?: string;

  @doc("Compliance summary for the policy assignment.")
  results?: SummaryResults;

  @doc("Policy definitions summary.")
  policyDefinitions?: PolicyDefinitionSummary[];

  @doc("Policy definition group summary.")
  policyGroups?: PolicyGroupSummary[];
}

@doc("Policy definition summary.")
model PolicyDefinitionSummary {
  @doc("Policy definition ID.")
  policyDefinitionId?: string;

  @doc("Policy definition reference ID.")
  policyDefinitionReferenceId?: string;

  @doc("Policy definition group names.")
  policyDefinitionGroupNames?: string[];

  @doc("Policy effect, i.e. policy definition action.")
  effect?: string;

  @doc("Compliance summary for the policy definition.")
  results?: SummaryResults;
}

@doc("Policy definition group summary.")
model PolicyGroupSummary {
  @doc("Policy group name.")
  policyGroupName?: string;

  @doc("Compliance summary for the policy definition group.")
  results?: SummaryResults;
}

@doc("The properties of the policy metadata.")
model PolicyMetadataProperties extends PolicyMetadataSlimProperties {
  @doc("The description of the policy metadata.")
  @visibility("read")
  description?: string;

  @doc("The requirements of the policy metadata.")
  @visibility("read")
  requirements?: string;
}

@doc("The properties of the policy metadata, excluding properties containing large strings")
model PolicyMetadataSlimProperties {
  @doc("The policy metadata identifier.")
  @visibility("read")
  metadataId?: string;

  @doc("The category of the policy metadata.")
  @visibility("read")
  category?: string;

  @doc("The title of the policy metadata.")
  @visibility("read")
  title?: string;

  @doc("The owner of the policy metadata.")
  @visibility("read")
  owner?: string;

  @doc("Url for getting additional content about the resource metadata.")
  @visibility("read")
  additionalContentUrl?: string;

  @doc("Additional metadata.")
  @visibility("read")
  metadata?: Record<unknown>;
}

@doc("Error response.")
@error
model PolicyMetadataErrorResponse {
  @doc("The error details.")
  error?: PolicyMetadataErrorDefinition;
}

@doc("Error definition.")
model PolicyMetadataErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("The target of the error.")
  @visibility("read")
  target?: string;

  @doc("Internal error details.")
  @visibility("read")
  details?: PolicyMetadataErrorDefinition[];

  @doc("Additional scenario specific error details.")
  @visibility("read")
  additionalInfo?: TypedErrorInfo[];
}

@doc("Slim version of policy metadata resource definition, excluding properties with large strings")
model SlimPolicyMetadata {
  @doc("Properties of the policy metadata.")
  properties?: PolicyMetadataSlimProperties;

  @doc("The ID of the policy metadata.")
  @visibility("read")
  id?: string;

  @doc("The type of the policy metadata.")
  @visibility("read")
  type?: string;

  @doc("The name of the policy metadata.")
  @visibility("read")
  name?: string;
}

@doc("The check policy restrictions parameters describing the resource that is being evaluated.")
model CheckRestrictionsRequest {
  @doc("The information about the resource that will be evaluated.")
  resourceDetails: CheckRestrictionsResourceDetails;

  @doc("The list of fields and values that should be evaluated for potential restrictions.")
  pendingFields?: PendingField[];
}

@doc("The information about the resource that will be evaluated.")
model CheckRestrictionsResourceDetails {
  @doc("The resource content. This should include whatever properties are already known and can be a partial set of all resource properties.")
  resourceContent: Record<unknown>;

  @doc("The api-version of the resource content.")
  apiVersion?: string;

  @doc("The scope where the resource is being created. For example, if the resource is a child resource this would be the parent resource's resource ID.")
  scope?: string;
}

@doc("A field that should be evaluated against Azure Policy to determine restrictions.")
model PendingField {
  @doc("The name of the field. This can be a top-level property like 'name' or 'type' or an Azure Policy field alias.")
  field: string;

  @doc("The list of potential values for the field that should be evaluated against Azure Policy.")
  values?: string[];
}

@doc("The result of a check policy restrictions evaluation on a resource.")
model CheckRestrictionsResult {
  @doc("The restrictions that will be placed on various fields in the resource by policy.")
  @visibility("read")
  fieldRestrictions?: FieldRestrictions[];

  @doc("Evaluation results for the provided partial resource content.")
  @visibility("read")
  contentEvaluationResult?: CheckRestrictionsResultContentEvaluationResult;
}

@doc("The restrictions that will be placed on a field in the resource by policy.")
model FieldRestrictions {
  @doc("The name of the field. This can be a top-level property like 'name' or 'type' or an Azure Policy field alias.")
  @visibility("read")
  field?: string;

  @doc("The restrictions placed on that field by policy.")
  restrictions?: FieldRestriction[];
}

@doc("The restrictions on a field imposed by a specific policy.")
model FieldRestriction {
  @doc("The type of restriction that is imposed on the field.")
  @visibility("read")
  result?: FieldRestrictionResult;

  @doc("The value that policy will set for the field if the user does not provide a value.")
  @visibility("read")
  defaultValue?: string;

  @doc("The values that policy either requires or denies for the field.")
  @visibility("read")
  values?: string[];

  @doc("The details of the policy that is causing the field restriction.")
  @visibility("read")
  policy?: PolicyReference;
}

@doc("Resource identifiers for a policy.")
model PolicyReference {
  @doc("The resource identifier of the policy definition.")
  @visibility("read")
  policyDefinitionId?: string;

  @doc("The resource identifier of the policy set definition.")
  @visibility("read")
  policySetDefinitionId?: string;

  @doc("The reference identifier of a specific policy definition within a policy set definition.")
  @visibility("read")
  policyDefinitionReferenceId?: string;

  @doc("The resource identifier of the policy assignment.")
  @visibility("read")
  policyAssignmentId?: string;
}

@doc("Evaluation results for the provided partial resource content.")
model CheckRestrictionsResultContentEvaluationResult {
  @doc("Policy evaluation results against the given resource content. This will indicate if the partial content that was provided will be denied as-is.")
  policyEvaluations?: PolicyEvaluationResult[];
}

@doc("The result of a non-compliant policy evaluation against the given resource content.")
model PolicyEvaluationResult {
  @doc("The details of the policy that was evaluated.")
  @visibility("read")
  policyInfo?: PolicyReference;

  @doc("The result of the policy evaluation against the resource. This will typically be 'NonCompliant' but may contain other values if errors were encountered.")
  @visibility("read")
  evaluationResult?: string;

  @doc("The detailed results of the policy expressions and values that were evaluated.")
  @visibility("read")
  evaluationDetails?: PolicyEvaluationDetails;
}

@doc("The check policy restrictions parameters describing the resource that is being evaluated.")
model CheckManagementGroupRestrictionsRequest {
  @doc("The information about the resource that will be evaluated.")
  resourceDetails?: CheckRestrictionsResourceDetails;

  @doc("The list of fields and values that should be evaluated for potential restrictions.")
  pendingFields?: PendingField[];
}

@doc("The properties of an attestation resource.")
model AttestationProperties {
  @doc("The resource ID of the policy assignment that the attestation is setting the state for.")
  policyAssignmentId: string;

  @doc("The policy definition reference ID from a policy set definition that the attestation is setting the state for. If the policy assignment assigns a policy set definition the attestation can choose a definition within the set definition with this property or omit this and set the state for the entire set definition.")
  policyDefinitionReferenceId?: string;

  @doc("The compliance state that should be set on the resource.")
  complianceState?: ComplianceState;

  @doc("The time the compliance state should expire.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresOn?: utcDateTime;

  @doc("The person responsible for setting the state of the resource. This value is typically an Azure Active Directory object ID.")
  owner?: string;

  @doc("Comments describing why this attestation was created.")
  comments?: string;

  @doc("The evidence supporting the compliance state set in this attestation.")
  evidence?: AttestationEvidence[];

  @doc("The status of the attestation.")
  @visibility("read")
  provisioningState?: string;

  @doc("The time the compliance state was last changed in this attestation.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastComplianceStateChangeAt?: utcDateTime;

  @doc("The time the evidence was assessed")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assessmentDate?: utcDateTime;

  @doc("Additional metadata for this attestation")
  metadata?: Record<unknown>;
}

@doc("A piece of evidence supporting the compliance state set in the attestation.")
model AttestationEvidence {
  @doc("The description for this piece of evidence.")
  description?: string;

  @doc("The URI location of the evidence.")
  sourceUri?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Error response.")
@error
model AttestationErrorResponse {
  @doc("The error details.")
  error?: AttestationErrorDefinition;
}

@doc("Error definition.")
model AttestationErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("The target of the error.")
  @visibility("read")
  target?: string;

  @doc("Internal error details.")
  @visibility("read")
  details?: AttestationErrorDefinition[];

  @doc("Additional scenario specific error details.")
  @visibility("read")
  additionalInfo?: TypedErrorInfo[];
}
