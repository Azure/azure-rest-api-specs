using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Approvals;

@doc("The input for the invokeAndFetchApprovalRequest POST call.")
model ApprovalRequestInput {
  @doc("The ARM resource ID of the ChangeState resource that the approval request is associated with.")
  changeStateId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/changeStates";
    }
  ]>;

  @doc("The name of the current stage progression of the ChangeState resource.")
  stageProgression: string;

  @doc("The resource that the approval request is associated with, if multiple resources are included in the ChangeState.")
  resourceId?: Azure.Core.armResourceIdentifier;
}

@doc("The output for the invokeAndFetchApprovalRequest POST call.")
model ApprovalRequestOutput {
  @doc("The current state of the approval request.")
  approvalRequestState: ApprovalWorkflowExecutionState;

  @doc("The approval token of the approval request.")
  approvalToken: string;
}

@armResourceOperations
interface ApprovalProvider {
  @doc("The ProviderLevelAction POST call to invoke and fetch the approval request.")
  invokeAndFetchApprovalRequest is ArmProviderActionSync<
    ApprovalRequestInput,
    ArmResponse<ApprovalRequestOutput>,
    SubscriptionActionScope
  >;
}
