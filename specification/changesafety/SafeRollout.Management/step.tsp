import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ChangeSafety;

@doc("Resource to track the rollout steps, with SafeRollout as parent resource.")
@parentResource(SafeRollout)
model Step is ProxyResource<StepProperties> {
  @doc("The name of the step")
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @key("stepName")
  @segment("steps")
  @path
  @minLength(3)
  @maxLength(100)
  name: string;
}

@doc("Azure resource Id of a StageProgression.")
scalar StageProgressionResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/changeStates/stageProgressions",
    }
  ]>;

@doc("Details of the properties of the Step.")
model StepProperties {
  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the step.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The status of the step.")
  status: Status;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Azure resource Id of the referenced stage progression.")
  stageProgressionResourceId: StageProgressionResourceId;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Step sequence id.")
  sequenceId: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Step operations array.")
  operations?: StepOperation[];
}

@doc("Object to track the operations of the step.")
model StepOperation {
  @doc("The name of the operation")
  name: string;

  @doc("Operation status.")
  status: OperationStatus;

  @doc("Operation status message.")
  statusMessage?: string;

  @doc("Operation id.")
  operationId: string;

  @doc("The operation type.")
  operationType: OperationType;

  @doc("The deployment name.")
  deploymentName?: string;

  @doc("Operation error.")
  error?: Error;
}

@doc("Indicates the current status of the operation.")
union OperationStatus {
  string,

  @doc("Step in progress.")
  InProgress: "InProgress",

  @doc("Step Succeeded.")
  Completed: "Succeeded",

  @doc("Step was canceled.")
  Canceled: "Canceled",

  @doc("Step is being canceled.")
  Canceling: "Canceling",

  @doc("Step is paused.")
  Paused: "Paused",

  @doc("Step failed.")
  Failed: "Failed",
}

@doc("The operation type.")
union OperationType {
  string,

  @doc("The validator execution.")
  Validator: "Validator",

  @doc("The operation to create or update the stage progression.")
  StageProgression: "StageProgression",

  @doc("The operation to deploy the ARM template, link to the deployment is included.")
  ARMTemplateDeployment: "ARMTemplateDeployment",
}

@armResourceOperations
interface Steps {
  get is ArmResourceRead<Step>;
  listBySubscription is ArmListBySubscription<Step>;
  listByParent is ArmResourceListByParent<Step>;
}
