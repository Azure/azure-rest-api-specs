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
union IdentityType {
  string,

  @doc("A user identity.")
  User: "User",

  @doc("A service principal identity.")
  ServicePrincipal: "ServicePrincipal",

  @doc("A security group identity.")
  SecurityGroup: "SecurityGroup",
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

  @doc("Whether this subscription uses a workflow. Derived from the data product's workflow settings; read-only on the wire.")
  @visibility(Lifecycle.Read)
  useWorkflow?: boolean;

  @doc("The workflow identifier associated with this subscription. Resolved server-side from the data product's workflow settings; read-only on the wire.")
  @visibility(Lifecycle.Read)
  workflowId?: string;

  @doc("The type of workflow. Resolved server-side from the data product's workflow settings; read-only on the wire.")
  @visibility(Lifecycle.Read)
  workflowType?: string;

  @doc("The name of the workflow. Resolved server-side from the data product's workflow settings; read-only on the wire.")
  @visibility(Lifecycle.Read)
  workflowName?: string;

  @doc("The governance domain path. Enriched server-side from the data product; read-only on the wire.")
  @visibility(Lifecycle.Read)
  governanceDomain?: string;

  @doc("Whether write access is requested. Resolved server-side from the request context; read-only on the wire.")
  @visibility(Lifecycle.Read)
  writeAccess?: boolean;

  @doc("The status of the subscription. Transitioned by the approve/reject/complete endpoints; read-only on the wire.")
  @visibility(Lifecycle.Read)
  subscriptionStatus?: DataSubscriptionStatus;

  @doc("The identity of the subscriber.")
  subscriberIdentity: Identity;

  @doc("The identity of the requestor.")
  requestorIdentity?: Identity;

  @doc("The domain identifier.")
  domainId?: uuid;

  @doc("The data product identifier.")
  dataProductId: uuid;

  @doc("The name of the data product. Enriched server-side from the referenced data product; read-only on the wire.")
  @visibility(Lifecycle.Read)
  dataProductName?: string;

  @doc("The name of the business domain. Enriched server-side from the referenced data product; read-only on the wire.")
  @visibility(Lifecycle.Read)
  businessDomainName?: string;

  @doc("A general comment for the subscription.")
  globalComment?: string;

  @doc("Policy set values for the subscription.")
  policySetValues: DataSubscriptionPolicySetValues;

  @doc("The creation timestamp.")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The user who created the subscription.")
  @visibility(Lifecycle.Read)
  createdBy?: string;

  @doc("The access expiration date. Computed server-side from the policy duration at approval time; read-only on the wire.")
  @visibility(Lifecycle.Read)
  accessExpirationDate?: utcDateTime;

  @doc("The date when the access decision was made.")
  @visibility(Lifecycle.Read)
  accessDecisionDate?: utcDateTime;

  @doc("The data assets included in the subscription.")
  dataAssets?: DataAssetValues[];

  @doc("The list of access provider identifiers. Derived server-side from the workflow approvers; read-only on the wire.")
  @visibility(Lifecycle.Read)
  accessProviders?: string[];

  @doc("Whether Power Automate is used. Resolved server-side from the data product's workflow settings; read-only on the wire.")
  @visibility(Lifecycle.Read)
  usePowerAutomate?: boolean;
}

@doc("The status of a data subscription.")
union DataSubscriptionStatus {
  string,

  @doc("Subscription is pending approval.")
  Pending: "Pending",

  @doc("Subscription has been approved.")
  Approved: "Approved",

  @doc("Access has been granted.")
  Granted: "Granted",

  @doc("Subscription has been declined.")
  Declined: "Declined",

  @doc("Access has been revoked.")
  Revoked: "Revoked",

  @doc("Subscription process is complete.")
  Completed: "Completed",
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
  @visibility(Lifecycle.Read)
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
union TriggerType {
  string,

  @doc("Triggered when a data access request is submitted.")
  DataAccessRequestSubmitted: "DataAccessRequestSubmitted",

  @doc("Triggered when a data product is published.")
  DataProductPublish: "DataProductPublish",

  @doc("Triggered when a term is published.")
  TermPublish: "TermPublish",
}

// ============================================================
// Workflow Actions (polymorphic on actionType)
// ============================================================

@doc("Base type for a step in a workflow's action DAG. The concrete shape is selected by the `actionType` discriminator.")
@discriminator("actionType")
model Action {
  @doc("The type of action, used as the polymorphic discriminator.")
  actionType: ActionType;

  @doc("The unique name of the action within the workflow. Names must be unique across the entire DAG.")
  actionName?: string;
}

@doc("The set of supported workflow action kinds.")
union ActionType {
  string,

  @doc("Starts an approval and waits for the response.")
  StartAndWaitForApproval: "StartAndWaitForApproval",

  @doc("Branches execution based on a boolean expression.")
  Condition: "Condition",

  @doc("Approves the parent data subscription.")
  ApproveDataSubscription: "ApproveDataSubscription",

  @doc("Rejects the parent data subscription.")
  RejectDataSubscription: "RejectDataSubscription",

  @doc("Completes the parent data subscription after access has been granted.")
  CompleteDataSubscription: "CompleteDataSubscription",

  @doc("Sends an email notification.")
  SendEmailNotification: "SendEmailNotification",

  @doc("Publishes a data product.")
  PublishDataProduct: "PublishDataProduct",

  @doc("Publishes a term.")
  PublishTerm: "PublishTerm",

  @doc("Grants access to data assets for self-service scenarios.")
  GrantAccessToAssets: "GrantAccessToAssets",
}

@doc("Starts an approval and waits for the response.")
model ApprovalAction extends Action {
  @doc("Discriminator value identifying this as a StartAndWaitForApproval action.")
  actionType: ActionType.StartAndWaitForApproval;

  @doc("Inputs that configure the approval request.")
  inputs?: ApprovalInputs;
}

@doc("Inputs that configure an ApprovalAction.")
model ApprovalInputs {
  @doc("The type of approval (e.g., 'Custom').")
  approvalType?: string;

  @doc("The title displayed on the approval request.")
  title?: string;

  @doc("The list of identities (object IDs) assigned to approve the request.")
  assignedTo?: string[];
}

@doc("Branches workflow execution based on a boolean expression.")
model ConditionAction extends Action {
  @doc("Discriminator value identifying this as a Condition action.")
  actionType: ActionType.Condition;

  @doc("Inputs that configure the branching condition and its branches.")
  inputs?: ConditionInputs;
}

@doc("Inputs that configure a ConditionAction.")
model ConditionInputs {
  @doc("The expressions evaluated to determine which branch to execute.")
  expressions?: Expression[];

  @doc("The actions to execute when the condition evaluates to true.")
  actions?: Action[];

  @doc("The actions to execute when the condition evaluates to false.")
  elseActions?: Action[];
}

@doc("A boolean expression evaluated by a ConditionAction.")
model Expression {
  @doc("The logical operator combining the operands (e.g., 'and', 'or').")
  type?: string;

  @doc("The left-hand side operand.")
  leftHandSide?: string;

  @doc("The right-hand side operand.")
  rightHandSide?: string;

  @doc("The equality comparison applied between the operands (e.g., 'IsEqualTo').")
  equality?: string;
}

@doc("Sends an email notification.")
model SendEmailNotificationAction extends Action {
  @doc("Discriminator value identifying this as a SendEmailNotification action.")
  actionType: ActionType.SendEmailNotification;

  @doc("Inputs that configure the email notification.")
  inputs?: SendEmailNotificationInputs;
}

@doc("Inputs that configure a SendEmailNotificationAction.")
model SendEmailNotificationInputs {
  @doc("The item the notification refers to.")
  item?: string;

  @doc("Additional body text appended to the notification.")
  additionalBody?: string;

  @doc("Additional subject text appended to the notification.")
  additionalSubject?: string;

  @doc("The list of identities (object IDs) that should receive the notification.")
  assignedTo?: uuid[];
}

@doc("Approves the parent data subscription.")
model ApproveDataSubscriptionAction extends Action {
  @doc("Discriminator value identifying this as an ApproveDataSubscription action.")
  actionType: ActionType.ApproveDataSubscription;
}

@doc("Rejects the parent data subscription.")
model RejectDataSubscriptionAction extends Action {
  @doc("Discriminator value identifying this as a RejectDataSubscription action.")
  actionType: ActionType.RejectDataSubscription;
}

@doc("Completes the parent data subscription after access has been granted.")
model CompleteDataSubscriptionAction extends Action {
  @doc("Discriminator value identifying this as a CompleteDataSubscription action.")
  actionType: ActionType.CompleteDataSubscription;
}

@doc("Publishes a data product.")
model PublishDataProductAction extends Action {
  @doc("Discriminator value identifying this as a PublishDataProduct action.")
  actionType: ActionType.PublishDataProduct;
}

@doc("Publishes a term.")
model PublishTermAction extends Action {
  @doc("Discriminator value identifying this as a PublishTerm action.")
  actionType: ActionType.PublishTerm;
}

@doc("Grants access to data assets for self-service scenarios.")
model GrantAccessToAssetsAction extends Action {
  @doc("Discriminator value identifying this as a GrantAccessToAssets action.")
  actionType: ActionType.GrantAccessToAssets;
}

@doc("Represents a workflow run instance.")
@resource("workflowRuns")
model WorkflowRun {
  @doc("The unique identifier of the workflow run record.")
  id?: uuid;

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

  @doc("The account identifier.")
  accountId?: uuid;

  @doc("The tenant identifier.")
  tenantId?: uuid;

  @doc("The version of the model.")
  version?: string;
}

@doc("Represents a workflow approval request that links a workflow run to its approvers.")
model ApprovalWorkflow {
  @doc("The unique identifier of the approval request.")
  approvalRequestId: uuid;

  @doc("The identifier of the workflow run this approval is associated with.")
  workflowRunId: uuid;

  @doc("The identifier of the workflow definition this approval is associated with.")
  workflowId: string;

  @doc("The callback URL the workflow uses to report the approval outcome.")
  callbackUrl: string;

  @doc("Indicates whether the approval requires action from every approver in the list.")
  isPendingOnAll: boolean;

  @doc("The list of approver object identifiers.")
  approvers: uuid[];

  @doc("The title of the approval request.")
  title: string;

  @doc("The current status of the approval (e.g., 'InProgress', 'Completed', 'Rejected').")
  status: string;

  @doc("The requestor identity - the person requesting data access.")
  requestorIdentity?: Identity;

  @doc("The subscriber identity - the person who will receive data access.")
  subscriberIdentity?: Identity;

  @visibility(Lifecycle.Read)
  @doc("The workflow type (e.g., 'DataAccessRequestSubmitted', 'DataProductPublish', 'TermPublish').")
  workflowType?: string;

  @visibility(Lifecycle.Read)
  @doc("The workflow name.")
  workflowName?: string;

  @visibility(Lifecycle.Read)
  @doc("The business concept name.")
  businessConcept?: string;

  @visibility(Lifecycle.Read)
  @doc("The governance domain name.")
  governanceDomain?: string;
}

@doc("Represents an approval action within a workflow run, including the status of each approver.")
model WorkflowRunApproval {
  @doc("The title of the approval action.")
  title?: string;

  @doc("The list of approval statuses for this approval action.")
  approvalStatuses?: WorkflowRunApprovalStatus[];
}

@doc("Represents the status of an individual approver within an approval action.")
model WorkflowRunApprovalStatus {
  @doc("The approver's object identifier.")
  approver?: uuid;

  @doc("The status of the approval (e.g., 'Pending', 'Approved', 'Declined').")
  status?: string;

  @doc("The comment provided by the approver.")
  comment?: string;
}

@doc("Request body for a workflow approve or reject action.")
model WorkflowActionRequest {
  @doc("Optional comment from the approver explaining the decision.")
  comment?: string;
}

// ============================================================
// Policy Set Models
// ============================================================

@doc("Represents an access policy set applied to a resource.")
@discriminator("policySetKind")
model PolicySet {
  @doc("The unique identifier of the policy set.")
  @visibility(Lifecycle.Read)
  policySetId?: uuid;

  @doc("The target resource for the policy set.")
  targetResource?: TargetResource;

  @doc("The kind of policy set.")
  policySetKind: PolicySetKind;
}

@doc("Policy set applied to a term.")
model TermPolicySet extends PolicySet {
  @doc("The kind of policy set.")
  policySetKind: PolicySetKind.Term;

  @doc("The term-level policies.")
  policies?: TermPolicies;
}

@doc("Policy set applied to a business domain.")
model DomainPolicySet extends PolicySet {
  @doc("The kind of policy set.")
  policySetKind: PolicySetKind.Domain;

  @doc("The domain-level policies.")
  policies?: DomainPolicies;
}

@doc("Policy set applied to a data product.")
model DataProductPolicySet extends PolicySet {
  @doc("The kind of policy set.")
  policySetKind: PolicySetKind.DataProduct;

  @doc("The data product policies.")
  policies?: DataProductPolicies;
}

@doc("Policy set applied to a critical data element.")
model CriticalDataElementPolicySet extends PolicySet {
  @doc("The kind of policy set.")
  policySetKind: PolicySetKind.CriticalDataElement;

  @doc("The critical data element policies.")
  policies?: CriticalDataElementPolicies;
}

@doc("The target resource for a policy set.")
model TargetResource {
  @doc("The target resource identifier.")
  targetId: uuid;

  @doc("The target resource type.")
  targetType: TargetType;
}

@doc("The type of governance entity that a policy set targets.")
union TargetType {
  string,

  @doc("Targets a business domain.")
  Domain: "Domain",

  @doc("Targets a data product.")
  DataProduct: "DataProduct",

  @doc("Targets a term.")
  Term: "Term",

  @doc("Targets a critical data element.")
  CriticalDataElement: "CriticalDataElement",
}

@doc("The kind of policy set, identifying the governance entity it applies to.")
union PolicySetKind {
  string,

  @doc("Policy set for a term.")
  Term: "Term",

  @doc("Policy set for a business domain.")
  Domain: "Domain",

  @doc("Policy set for a data product.")
  DataProduct: "DataProduct",

  @doc("Policy set for a critical data element.")
  CriticalDataElement: "CriticalDataElement",
}

@doc("Base properties shared by every policy variant.")
model BasePolicies {
  @doc("Attestations that policy approvers must acknowledge.")
  attestations?: PolicyAttestation[];

  @doc("Whether manager approval is required for access requests.")
  managerApprovalRequired?: boolean;

  @doc("Whether data may be copied by subscribers after access is granted.")
  dataCopyPermitted?: boolean;
}

@doc("Term-level access policies.")
model TermPolicies {
  ...BasePolicies;
}

@doc("Domain-level access policies.")
model DomainPolicies {
  ...BasePolicies;
}

@doc("Critical data element-level access policies.")
model CriticalDataElementPolicies {
  ...BasePolicies;
}

@doc("Data product access policies.")
model DataProductPolicies {
  ...BasePolicies;

  @doc("The approval timeline duration (ISO 8601).")
  approvalTimeline?: duration;

  @doc("Permitted use cases for the data product.")
  permittedUseCases: UseCase[];

  @doc("Permitted subscriber identity types.")
  permittedSubscribers?: IdentityType[];

  @doc("The list of approvers.")
  approvers: Identity[];

  @doc("The list of data access grantors.")
  dataAccessGrantors?: Identity[];

  @doc("Sensitive markers applied to the data product.")
  sensitiveMarkers?: SensitiveMarker[];

  @doc("Whether terms of use acceptance is required.")
  termsOfUseRequired?: boolean;

  @doc("Whether sharing with partners is permitted.")
  partnerSharingPermitted?: boolean;

  @doc("Whether sharing with customers is permitted.")
  customerSharingPermitted?: boolean;

  @doc("The maximum access duration (ISO 8601).")
  maximumAccessDuration?: duration;

  @doc("Whether privacy compliance approval is required.")
  privacyComplianceApprovalRequired?: boolean;

  @doc("Whether the workflow can be skipped.")
  skipWorkflow?: boolean;

  @doc("Whether Power Automate is used.")
  usePowerAutomate?: boolean;
}

@doc("An attestation that a policy approver must acknowledge.")
model PolicyAttestation {
  @doc("The display name of the attestation.")
  displayName?: string;

  @doc("A reference to the supporting document.")
  documentReference?: string;

  @doc("Whether the attestation is required.")
  required?: boolean;
}

@doc("A use case describing how a data product may be used.")
model UseCase {
  @doc("The title of the use case.")
  title?: string;

  @doc("The description of the use case.")
  description?: string;
}

@doc("A sensitive marker that restricts which subscribers may access a data product.")
model SensitiveMarker {
  @doc("The security group that the marker applies to.")
  securityGroup?: Identity;

  @doc("The classification tags carried by the marker.")
  tags?: Tag[];
}

@doc("A classification tag.")
model Tag {
  @doc("The type of the tag.")
  type?: TagType;

  @doc("The value of the tag.")
  value?: string;
}

@doc("The classification of a sensitive marker tag value.")
union TagType {
  string,

  @doc("A glossary term reference.")
  Term: "Term",

  @doc("A classification (e.g., sensitivity classification).")
  Classification: "Classification",

  @doc("A free-form label.")
  Label: "Label",

  @doc("A governance-related tag.")
  Governance: "Governance",
}

// ============================================================
// Response Models
// ============================================================

@doc("Response with workflow settings for a data product.")
model DataProductWorkflowSettingsResponse {
  @doc("Whether the skip workflow option is enabled.")
  skipWorkflowEnabled: boolean;

  @doc("Whether Power Automate is used.")
  usePowerAutomate: boolean;
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

@doc("List of term policy sets.")
model TermPolicySetListResponse {
  @doc("The list of term policy sets.")
  value: TermPolicySet[];
}

@doc("List of critical data element policy sets.")
model CriticalDataElementPolicySetListResponse {
  @doc("The list of critical data element policy sets.")
  value: CriticalDataElementPolicySet[];
}

// ============================================================
// Path parameter aliases
// Reusable alias models for path parameters, used to satisfy
// the no-rpc-path-params linter rule by relying on implicit
// path parameter detection via name matching with route templates.
// ============================================================

alias DataSubscriptionIdParameter = {
  @doc("The data subscription identifier.")
  dataSubscriptionId: uuid;
};

alias WorkflowIdParameter = {
  @doc("The workflow identifier.")
  workflowId: uuid;
};

alias WorkflowRunIdParameter = {
  @doc("The workflow run identifier.")
  workflowRunId: uuid;
};

alias WorkflowIdAndRunIdParameters = {
  @doc("The workflow identifier.")
  workflowId: uuid;

  @doc("The workflow run identifier.")
  workflowRunId: uuid;
};

alias TriggerTypeParameter = {
  @doc("The trigger type.")
  triggerType: string;
};

alias DataProductIdParameter = {
  @doc("The data product identifier.")
  dataProductId: uuid;
};

alias DomainIdParameter = {
  @doc("The business domain identifier.")
  domainId: uuid;
};

alias TermIdParameter = {
  @doc("The term identifier.")
  termId: uuid;
};

alias CriticalDataElementIdParameter = {
  @doc("The critical data element identifier.")
  criticalDataElementId: uuid;
};
