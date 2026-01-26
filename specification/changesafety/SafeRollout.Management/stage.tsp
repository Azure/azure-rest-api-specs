import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ChangeSafety;

@doc("Resource to track the rollout stages, with SafeRollout as parent resource.")
@parentResource(SafeRollout)
@added(Versions.v2026_01_01_preview)
model Stage is ProxyResource<StageProperties> {
  @doc("The name of the stage")
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @key("stageName")
  @segment("stages")
  @path
  @minLength(3)
  @maxLength(100)
  name: string;
}

@doc("Details of the properties of the stage.")
@added(Versions.v2026_01_01_preview)
model StageProperties {
  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the stage.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The status of the stage.")
  status: Status;

  @visibility(Lifecycle.Read)
  @doc("Azure resource Id of the referenced stage progression.")
  stageProgressionResourceId: StageProgressionResourceId;

  @visibility(Lifecycle.Read)
  @doc("Stage sequence id.")
  sequenceId: string;

  @visibility(Lifecycle.Read)
  @doc("Stage actions array.")
  @identifiers(#["name", "retryAttempt"])
  actions?: Action[];

  @visibility(Lifecycle.Read)
  @doc("The start time of the stage.")
  startTime?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The end time of the stage.")
  endTime?: utcDateTime;
}

@doc("Object to track the actions of the stage.")
@added(Versions.v2026_01_01_preview)
model Action {
  @doc("The name of the action")
  name: ActionName;

  @doc("Action status.")
  status: Status;

  @doc("The deployment name.")
  deploymentName?: string;

  @doc("Action error.")
  error?: Error;

  @doc("The start time of the action.")
  startTime?: utcDateTime;

  @doc("The end time of the action.")
  endTime?: utcDateTime;

  @doc("The retry attempt.")
  retryAttempt?: int32;
}

@doc("The action name.")
@added(Versions.v2026_01_01_preview)
union ActionName {
  string,

  @doc("Open Stage.")
  OpenStage: "OpenStage",

  @doc("The Arm deployment.")
  Deploy: "The Arm deployment.",

  @doc("Close Stage.")
  CloseStage: "CloseStage",
}

@armResourceOperations
interface Stages {
  @added(Versions.v2026_01_01_preview)
  get is ArmResourceRead<Stage>;
  @added(Versions.v2026_01_01_preview)
  listBySubscription is ArmListBySubscription<Stage>;
  @added(Versions.v2026_01_01_preview)
  listByParent is ArmResourceListByParent<Stage>;
  @doc("Retry the SafeRollout stage.")
  @added(Versions.v2026_01_01_preview)
  retry is ArmResourceActionNoContentSync<
    Stage,
    Stage,
    OptionalRequestBody = true
  >;
}
