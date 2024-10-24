import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";
import "./stageprogression.tsp";
import "./stagemap.tsp";
import "./changeartifact.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.ChangeSafety;

@doc("Resource allows the user to define the change that they intended to execute & indicate the progression it will use.")
@extensionResource
model ChangeState is ProxyResource<ChangeStateProperties> {
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @key("changeStateName")
  @segment("changeStates")
  @path
  @visibility("read")
  @minLength(3)
  @maxLength(100)
  @doc("The name of the ChangeState resource.")
  name: string;
}

@doc("Detailed properties of the ChangeState resource.")
model ChangeStateProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create")
  @doc("Describes the type of the change.")
  changeType: ChangeType;

  @visibility("read", "create", "update")
  @doc("Brief description about the change.")
  @maxLength(2000)
  description?: string;

  @visibility("read", "create")
  @doc("Azure resource Id of the referenced StageMap.")
  stageMapResourceId: string;

  @visibility("read", "create")
  @doc("Object that describes the change payload.")
  changeArtifact: ChangeArtifact;

  @visibility("read", "create")
  @doc("Change is expected to be completed by date, in ISO 8601 format.")
  expirationDate: utcDateTime;

  @visibility("read", "create", "update")
  @doc("URI to the external service catalog reference.")
  serviceCatalogReference?: url;

  @visibility("read", "create", "update")
  @doc("URI to the work item related to this change.")
  workItemReference?: url;

  @visibility("read", "create", "update")
  @doc("Internal status of the changestate resource.")
  state: ChangeStatus;

  @visibility("read", "create", "update")
  @doc("Comments about the last update to the changeState resource.")
  @maxLength(2000)
  comments?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  @doc("Schema of parameters that will be provided for each stageProgression.")
  @visibility("read", "create")
  stageParameters: Record<Parameter>;

  @doc("Referenced stagemap snapshot.")
  @visibility("hidden")
  stageMapSnapshot?: string;
}

@doc("RetrieveNextStage POST Action response.")
model RetrieveNextStagesResponse {
  @doc("ChangeState resource Id.")
  changeStateResourceId: string;

  @doc("Last stage sequence in the StageProgression.")
  lastStageSequence: int32;

  @doc("StageProgression resources that are ready to put in 'InProgress' state.")
  @OpenAPI.extension("x-ms-identifiers", ["stageReference"])
  nextStages: RetrieveNextStagesResponseItem[];
}

@doc("StageProgression data comes from RetrieveNextStages API.")
model RetrieveNextStagesResponseItem {
  @doc("Stage name relevant to the hierarchical StageMap. Identifies the stage uniquely within a changestate resource.")
  @visibility("read")
  stageReference: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  @doc("Parameters to apply on the change for the stage.")
  @visibility("read")
  parameterValues: Record<string | int32>;
}

@doc("Internal status of the ChangeState resource.")
union ChangeStatus {
  string,

  @doc("Resource initialized status.")
  Initialized: "Initialized",

  @doc("Resource is currently In progress.")
  InProgress: "InProgress",

  @doc("Resource is completed the execution.")
  Completed: "Completed",

  @doc("Resource is Abandoned.")
  Abandoned: "Abandoned",

  @doc("Resource is in Paused state.")
  Paused: "Paused",

  @doc("Resource is in Failed state.")
  Failed: "Failed",
}

@doc("Defines the Kind of the intended Change.")
union ChangeType {
  string,

  @doc("Regular resource change.")
  Normal: "Normal",

  @doc("An Emergency type resource change.")
  Emergency: "Emergency",

  @doc("Breakglass level resource change.")
  Breakglass: "Breakglass",
}

@armResourceOperations
@doc("The operations of the ChangeState resource.")
interface ChangeStates {
  get is ArmResourceRead<ChangeState>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ChangeState>;
  update is ArmResourcePatchSync<ChangeState, ChangeStateProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<ChangeState>;

  @doc("Gets list of next stages that are eligible to put in 'InProgress' state in a changestate resource.")
  @action("retrieveNextStages")
  retrieveNextStages is ArmResourceActionSync<
    ChangeState,
    void,
    RetrieveNextStagesResponse
  >;
}
