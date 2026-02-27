using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Approvals;

@doc("ApprovalWorkflowAssignment ARM resource")
model ApprovalWorkflowAssignment
  is ExtensionResource<ApprovalWorkflowAssignmentProperties> {
  ...ResourceNameParameter<ApprovalWorkflowAssignment>;
  ...EntityTagProperty;
}

@doc("RP-specific properties of an ApprovalWorkflowAssignment resource")
model ApprovalWorkflowAssignmentProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The hierarchical scope at which the approval workflow is assigned.")
  scope?: string;

  @doc("The ARM resource id of the ApprovalWorkflowDefinition associated with this assignment.")
  approvalWorkflowDefinitionId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Approvals/approvalWorkflowDefinitions";
    }
  ]>;
}

@armResourceOperations(ApprovalWorkflowAssignment)
interface ApprovalWorkflowAssignments {
  get is ArmResourceRead<ApprovalWorkflowAssignment>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApprovalWorkflowAssignment>;
  update is ArmResourcePatchAsync<
    ApprovalWorkflowAssignment,
    ApprovalWorkflowAssignmentProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ApprovalWorkflowAssignment>;
  listByParent is ArmResourceListByParent<ApprovalWorkflowAssignment>;
}
