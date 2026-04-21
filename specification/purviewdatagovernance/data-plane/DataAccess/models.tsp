import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace PurviewDataAccess;

// ============================================================
// Common Models
// ============================================================

@doc("Identity information for a user or group.")
model Identity {
  @doc("The type of identity.")
  identityType?: IdentityType;

  @doc("The object ID of the identity.")
  objectId?: uuid;

  @doc("The tenant ID of the identity.")
  tenantId?: uuid;

  @doc("The display name of the identity.")
  displayName?: string;

  @doc("The email address of the identity.")
  email?: string;
}

@doc("The type of identity.")
enum IdentityType {
  @doc("A user identity.")
  User,

  @doc("A group identity.")
  Group,

  @doc("A service principal identity.")
  ServicePrincipal,
}

// ============================================================
// Data Subscription Models
// ============================================================

@doc("Represents a data access subscription request.")
@resource("dataSubscriptions")
model DataSubscription {
  @key("dataSubscriptionId")
  @doc("The unique identifier of the data subscription.")
  @visibility(Lifecycle.Read)
  dataSubscriptionId: uuid;

  @doc("Whether this subscription uses a workflow.")
  useWorkflow?: boolean;

  @doc("The workflow identifier associated with this subscription.")
  workflowId?: string;

  @doc("The type of workflow.")
  workflowType?: string;

  @doc("The name of the workflow.")
  workflowName?: string;

  @doc("The governance domain path.")
  governanceDomain?: string;

  @doc("Whether write access is requested.")
  writeAccess?: boolean;

  @doc("The status of the subscription.")
  subscriptionStatus?: DataSubscriptionStatus;

  @doc("The identity of the subscriber.")
  subscriberIdentity?: Identity;

  @doc("The identity of the requestor.")
  requestorIdentity?: Identity;

  @doc("The domain identifier.")
  domainId?: uuid;

  @doc("The data product identifier.")
  dataProductId?: uuid;

  @doc("The name of the data product.")
  dataProductName?: string;

  @doc("The name of the business domain.")
  businessDomainName?: string;

  @doc("A general comment for the subscription.")
  globalComment?: string;

  @doc("Policy set values for the subscription.")
  policySetValues?: DataSubscriptionPolicySetValues;

  @doc("The creation timestamp.")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The user who created the subscription.")
  @visibility(Lifecycle.Read)
  createdBy?: string;

  @doc("The access expiration date.")
  accessExpirationDate?: utcDateTime;

  @doc("The date when the access decision was made.")
  @visibility(Lifecycle.Read)
  accessDecisionDate?: utcDateTime;

  @doc("The data assets included in the subscription.")
  dataAssets?: DataAssetValues[];

  @doc("The list of access provider identifiers.")
  accessProviders?: string[];

  @doc("Whether Power Automate is used.")
  usePowerAutomate?: boolean;
}

@doc("The status of a data subscription.")
enum DataSubscriptionStatus {
  @doc("Subscription is pending approval.")
  Pending,

  @doc("Subscription has been approved.")
  Approved,

  @doc("Access has been granted.")
  Granted,

  @doc("Subscription has been declined.")
  Declined,

  @doc("Access has been revoked.")
  Revoked,

  @doc("Subscription process is complete.")
  Completed,
}

@doc("Policy set values associated with a data subscription.")
model DataSubscriptionPolicySetValues {
  @doc("The use cases for the subscription.")
  useCases?: string[];

  @doc("The terms of use acceptance.")
  termsOfUseAccepted?: boolean;

  @doc("Comments from the requestor.")
  requestorComments?: string;
}

@doc("Data asset values included in a subscription.")
model DataAssetValues {
  @doc("The data asset identifier.")
  dataAssetId?: uuid;

  @doc("The data asset name.")
  dataAssetName?: string;

  @doc("The data asset type.")
  dataAssetType?: string;
}

// ============================================================
// Workflow Models
// ============================================================

@doc("Represents a data access workflow definition.")
@resource("workflows")
model Workflow {
  @key("workflowId")
  @doc("The unique identifier of the workflow.")
  workflowId: uuid;

  @doc("The type of workflow.")
  type?: string;

  @doc("The name of the workflow.")
  name?: string;

  @doc("Whether the workflow is enabled.")
  isEnabled?: boolean;

  @doc("The description of the workflow.")
  description?: string;

  @doc("The triggers that activate this workflow.")
  triggers?: Trigger[];

  @doc("The action DAG (directed acyclic graph) defining the workflow steps.")
  actionDag?: Action[];

  @doc("The user who created the workflow.")
  @visibility(Lifecycle.Read)
  createdBy?: string;

  @doc("The user who last modified the workflow.")
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  @doc("The list of access provider identifiers.")
  accessProviders?: string[];
}

@doc("A trigger that activates a workflow.")
model Trigger {
  @doc("The type of trigger.")
  type?: TriggerType;

  @doc("The scope of the trigger.")
  underGlossaryHierarchy?: string;
}

@doc("The type of trigger that activates a workflow.")
enum TriggerType {
  @doc("Triggered when a data access request is submitted.")
  DataAccessRequestSubmitted,

  @doc("Triggered when a data product is published.")
  DataProductPublish,

  @doc("Triggered when a term is published.")
  TermPublish,
}

@doc("An action step in a workflow.")
model Action {
  @doc("The unique identifier of the action.")
  actionId?: string;

  @doc("The type of action.")
  actionType?: string;

  @doc("The parameters for the action.")
  parameters?: Record<string>;
}

@doc("Represents a workflow run instance.")
@resource("workflowRuns")
model WorkflowRun {
  @key("workflowRunId")
  @doc("The unique identifier of the workflow run.")
  @visibility(Lifecycle.Read)
  workflowRunId: uuid;

  @doc("The workflow identifier.")
  workflowId?: uuid;

  @doc("The subscriber identity.")
  subscriber?: Identity;

  @doc("The requestor identity.")
  requestor?: Identity;

  @doc("The status of the workflow run.")
  status?: string;

  @doc("The type of workflow.")
  workflowType?: string;

  @doc("The name of the workflow.")
  workflowName?: string;

  @doc("The name of the workflow run.")
  workflowRunName?: string;

  @doc("The description of the workflow.")
  workflowDescription?: string;

  @doc("The triggers for this run.")
  triggers?: Trigger[];

  @doc("The action DAG for this run.")
  actionDag?: Action[];

  @doc("The creation timestamp.")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The user who created the run.")
  @visibility(Lifecycle.Read)
  createdBy?: string;

  @doc("The last modification timestamp.")
  @visibility(Lifecycle.Read)
  modifiedAt?: utcDateTime;

  @doc("The user who last modified the run.")
  @visibility(Lifecycle.Read)
  modifiedBy?: string;
}

@doc("Represents a workflow approval.")
model ApprovalWorkflow {
  @doc("The workflow run identifier.")
  workflowRunId?: uuid;

  @doc("The workflow identifier.")
  workflowId?: uuid;

  @doc("The subscriber identity.")
  subscriber?: Identity;

  @doc("The requestor identity.")
  requestor?: Identity;

  @doc("The approval status.")
  approvalStatus?: string;

  @doc("The workflow type.")
  workflowType?: string;

  @doc("The workflow name.")
  workflowName?: string;

  @doc("The data product name.")
  dataProductName?: string;

  @doc("The governance domain.")
  governanceDomain?: string;
}

@doc("Approver decision on a workflow run.")
model ApproverDecision {
  @doc("The approver identity.")
  approver?: Identity;

  @doc("The decision made.")
  decision?: ApproverDecisionStatus;

  @doc("The type of approver decision.")
  approverDecisionType?: string;

  @doc("Comments from the approver.")
  comments?: string;

  @doc("Data assets included in the decision.")
  dataAssets?: DataAssetValues[];
}

@doc("The status of an approver's decision.")
enum ApproverDecisionStatus {
  @doc("Approved the request.")
  Approved,

  @doc("Rejected the request.")
  Rejected,

  @doc("Decision is pending.")
  Pending,
}

@doc("Represents an approval record for a workflow run.")
model WorkflowRunApproval {
  @doc("The unique identifier of the approval.")
  approvalId?: uuid;

  @doc("The workflow run identifier.")
  workflowRunId?: uuid;

  @doc("The approver identity.")
  approver?: Identity;

  @doc("The decision made on this approval.")
  decision?: ApproverDecisionStatus;

  @doc("Comments from the approver.")
  comments?: string;

  @doc("The date the approval decision was made.")
  decisionDate?: utcDateTime;
}

// ============================================================
// Policy Set Models
// ============================================================

@doc("Represents an access policy set applied to a resource.")
model PolicySet {
  @doc("The unique identifier of the policy set.")
  @visibility(Lifecycle.Read)
  policySetId?: uuid;

  @doc("The target resource for the policy set.")
  targetResource?: TargetResource;

  @doc("The kind of policy set.")
  policySetKind?: PolicySetKind;

  @doc("The data product policies.")
  dataProductPolicies?: DataProductPolicies;
}

@doc("The target resource for a policy set.")
model TargetResource {
  @doc("The resource identifier.")
  resourceId?: uuid;

  @doc("The resource type.")
  resourceType?: string;
}

@doc("The kind of policy set.")
enum PolicySetKind {
  @doc("Applied policy set.")
  Applied,

  @doc("Effective policy set.")
  Effective,
}

@doc("Data product access policies.")
model DataProductPolicies {
  @doc("The approval timeline duration.")
  approvalTimeline?: string;

  @doc("Permitted use cases.")
  permittedUseCases?: string[];

  @doc("Permitted subscriber identity types.")
  permittedSubscribers?: IdentityType[];

  @doc("The list of approvers.")
  approvers?: Identity[];

  @doc("The list of data access grantors.")
  dataAccessGrantors?: Identity[];

  @doc("Sensitive markers applied to the data product.")
  sensitiveMarkers?: string[];

  @doc("Whether terms of use acceptance is required.")
  termsOfUseRequired?: boolean;

  @doc("Whether sharing with partners is permitted.")
  partnerSharingPermitted?: boolean;

  @doc("Whether sharing with customers is permitted.")
  customerSharingPermitted?: boolean;

  @doc("The maximum access duration.")
  maximumAccessDuration?: string;

  @doc("Whether privacy compliance approval is required.")
  privacyComplianceApprovalRequired?: boolean;

  @doc("Whether the workflow can be skipped.")
  skipWorkflow?: boolean;

  @doc("Whether Power Automate is used.")
  usePowerAutomate?: boolean;
}

// ============================================================
// Response Models
// ============================================================

@doc("Response indicating whether a workflow run is in progress.")
model WorkflowRunInProgressResponse {
  @doc("Whether a workflow run is currently in progress.")
  inProgress: boolean;
}

@doc("Response indicating whether a publish workflow is enabled.")
model PublishWorkflowEnabledResponse {
  @doc("Whether an enabled publish workflow exists.")
  exists: boolean;
}

@doc("Response with workflow settings for a data product.")
model DataProductWorkflowSettingsResponse {
  @doc("Whether the skip workflow option is enabled.")
  skipWorkflowEnabled: boolean;

  @doc("Whether Power Automate is used.")
  usePowerAutomate: boolean;
}

@doc("Response with active subscriber count.")
model ActiveSubscribersResponse {
  @doc("The number of active subscribers.")
  activeSubscribers: int32;
}

@doc("Response for delete operations.")
model DeleteResponse {
  @doc("Whether the delete operation was successful.")
  success: boolean;
}

@doc("List of workflow actions (template).")
model ActionListResponse {
  @doc("The list of actions.")
  value: Action[];
}

@doc("List of approval workflows.")
model ApprovalWorkflowListResponse {
  @doc("The list of approval workflows.")
  value: ApprovalWorkflow[];
}

@doc("List of workflow runs.")
model WorkflowRunListResponse {
  @doc("The list of workflow runs.")
  value: WorkflowRun[];
}

@doc("List of workflow run approvals.")
model WorkflowRunApprovalListResponse {
  @doc("The list of workflow run approvals.")
  value: WorkflowRunApproval[];
}

@doc("List of policy sets.")
model PolicySetListResponse {
  @doc("The list of policy sets.")
  value: PolicySet[];
}
