using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Approvals;

@doc("The ApprovalWorkflowInstance ARM resource")
@parentResource(ApprovalWorkflowDefinition)
model ApprovalWorkflowInstance
  is ProxyResource<ApprovalWorkflowInstanceProperties> {
  ...ResourceNameParameter<ApprovalWorkflowInstance>;
  ...EntityTagProperty;
}

@doc("RP-specific properties of an ApprovalWorkflowInstance resource")
model ApprovalWorkflowInstanceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The one who attempted to make the change for approvals.")
  @visibility(Lifecycle.Read)
  requestedBy: string;

  @doc("The ARM resource id of the change that the approval workflow instance was associated with. For example, the change state resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  requestedFor?: Azure.Core.armResourceIdentifier;

  @doc("The description of the change.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string;

  @doc("The change manifest associated with the approval workflow instance, free-formed and could be a serialized json string.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  changeManifest: string;

  @doc("The snapshot of the approval rule of the parent ApprovalWorkflowDefinition resource at the time the approval workflow instance was created.")
  @visibility(Lifecycle.Read)
  approvalRuleSnapshot: ApprovalRule;

  @doc("The latest execution state of the approval workflow instance.")
  @visibility(Lifecycle.Read)
  executionState: ApprovalWorkflowExecutionState;

  @doc("The latest status of each stage.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #["name"])
  stageStatuses: ApprovalStageExecutionStatus[];
}

@doc("Enum of the overall execution state of an approval workflow instance.")
union ApprovalWorkflowExecutionState {
  string,

  @doc("The approval workflow instance is in progress.")
  InProgress: "InProgress",

  @doc("The approval workflow instance has finished with all approval rules satisfied.")
  Approved: "Approved",

  @doc("The approval workflow instance has ended without approval rules satisfied.")
  Rejected: "Rejected",

  @doc("The approval workflow instance has been timed out.")
  Timedout: "Timedout",

  @doc("The approval workflow instance has been faulted.")
  Faulted: "Faulted",
}

@doc("Execution status of a stage in an approval workflow instance.")
model ApprovalStageExecutionStatus {
  @doc("The name of the stage.")
  name: string;

  @doc("The latest execution state of the stage.")
  state: ApprovalStageExecutionState;

  @doc("The approvers' sign-off statuses for the stage.")
  @extension("x-ms-identifiers", #["approver"])
  signoffs: ApproverSignoffStatus[];
}

@doc("Enum of state of a stage in an approval workflow instance.")
union ApprovalStageExecutionState {
  string,

  @doc("The initial state of the approval stage.")
  Created: "Created",

  @doc("The stage is ready to accept signoffs.")
  Started: "Started",

  @doc("The stage has finished with approved result.")
  Approved: "Approved",

  @doc("The stage has ended with rejected result.")
  Rejected: "Rejected",

  @doc("The stage has been faulted.")
  Faulted: "Faulted",
}

@doc("Approver's sign-off status.")
model ApproverSignoffStatus {
  @doc("The identifier of the person who takes the sign-off action.")
  approver: string;

  @doc("The action the approver has taken.")
  signoffAction: ApproverSignoffAction;

  @doc("The datetime when the approver took the sign-off action.")
  signoffDateTime: utcDateTime;
}

@doc("Enum of approver sign-off action.")
union ApproverSignoffAction {
  string,

  @doc("The approver has not yet being asked to take an action.")
  NotStarted: "NotStarted",

  @doc("The approver has not taken an action.")
  Pending: "Pending",

  @doc("The approver has approved.")
  Approved: "Approved",

  @doc("The approver has rejected.")
  Rejected: "Rejected",
}

@doc("Input for starting execution of a stage in an approval workflow instance.")
model ApprovalStageExecutionInput {
  @doc("The name of the stage.")
  stageName: string;
}

@armResourceOperations(ApprovalWorkflowInstance)
interface ApprovalWorkflowInstances {
  get is ArmResourceRead<ApprovalWorkflowInstance>;
  create is ArmResourceCreateOrReplaceSync<ApprovalWorkflowInstance>;
  delete is ArmResourceDeleteSync<ApprovalWorkflowInstance>;
  listByParent is ArmResourceListByParent<ApprovalWorkflowInstance>;
  executeStage is ArmResourceActionNoResponseContentAsync<
    ApprovalWorkflowInstance,
    ApprovalStageExecutionInput
  >;
}
