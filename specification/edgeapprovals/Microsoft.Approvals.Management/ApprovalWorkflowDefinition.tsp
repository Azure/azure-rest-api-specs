using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Approvals;

@doc("ApprovalWorkflowDefinition ARM resource.")
model ApprovalWorkflowDefinition
  is ExtensionResource<ApprovalWorkflowDefinitionProperties> {
  ...ResourceNameParameter<ApprovalWorkflowDefinition>;
  ...EntityTagProperty;
}

@doc("RP-specific properties of an ApprovalWorkflowDefinition resource.")
model ApprovalWorkflowDefinitionProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The reference to a custom Logic App.")
  logicAppRef?: LogicAppRef;

  @doc("The rule about the stages, approvers and their orders for the approval workflow.")
  approvalRule: ApprovalRule;

  @doc("The hierarchical scope under which this approval workflow is assignable.")
  scope?: string;
}

@doc("Reference to a Logic App resource.")
model LogicAppRef {
  @doc("The workflow URL of the Logic App.")
  workflowUrl: string;
}

@doc("Rule rule about the stages, approvers and their orders for the approval workflow.")
model ApprovalRule {
  @doc("The definitions of all the stages in the approval workflow.")
  @extension("x-ms-identifiers", #["name"])
  stages: ApprovalStage[];

  @doc("The maximum time in minutes that the approval workflow can be executed. The min value is 1 minute. The max value is 90 days. The default value is 7 days in the backend service.")
  @minValue(1)
  @maxValue(129600)
  timeoutInMinutes?: int32;
}

@doc("Definition of an stage in an approval workflow.")
model ApprovalStage {
  @doc("The name of the stage, unique within a single approval workflow definition.")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @doc("The logic rules about how the stage depends on other stages, representing as a JSON object.")
  dependsOn?: {};

  @doc("The list of identifiers of approvers in the stage.")
  approvers: string[];

  @doc("The minimal number of approvals required to complete the stage. The default value '1' means at least one approval is needed.")
  quorum: int32 = 1;
}

@armResourceOperations(ApprovalWorkflowDefinition)
interface ApprovalWorkflowDefinitions {
  get is ArmResourceRead<ApprovalWorkflowDefinition>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApprovalWorkflowDefinition>;
  update is ArmResourcePatchAsync<
    ApprovalWorkflowDefinition,
    ApprovalWorkflowDefinitionProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ApprovalWorkflowDefinition>;
  listByParent is ArmResourceListByParent<ApprovalWorkflowDefinition>;
}
