import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ChangeSafety;

@doc("Defines the progression of a change using these child resources, with ChangeState parent resource.")
@parentResource(ChangeState)
model StageProgression is ProxyResource<StageProgressionProperties> {
  @doc("name of the stageProgression")
  @key("stageProgressionName")
  @segment("stageProgressions")
  @pattern("^[a-zA-Z0-9-|]{3,100}$")
  @minLength(3)
  @maxLength(100)
  @path
  name: string;
}

@doc("Detailed properties of the StageProgression resource.")
model StageProgressionProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create", "update")
  @doc("Stage name relevant to hierarchical StageMap.")
  @minLength(3)
  @maxLength(200)
  stageReference: string;

  @visibility("read", "create", "update")
  @doc("StageProgression resource state.")
  state: StageProgressionState;

  @visibility("read")
  @doc("The sequence of the stage within the ChangeStage parent resource.")
  @minValue(1)
  sequence?: int32;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  @doc("Parameters to apply on the change of that stage. Key value pairs of parameter and values.")
  @visibility("read", "create", "update")
  parameterValues: Record<string | int32>;

  @visibility("read", "create", "update")
  @doc("Comments about the update to the resource.")
  @maxLength(2000)
  comments?: string;
}

@doc("Indicates the current status of the progression of the change within the stage.")
union StageProgressionState {
  string,

  @doc("Change is initialized to be applied within the stage.")
  Initialized: "Initialized",

  @doc("Change is being applied within the stage.")
  InProgress: "InProgress",

  @doc("Change has successfully been applied to the stage.")
  Completed: "Completed",

  @doc("Change apply operation was abandoned.")
  Abandoned: "Abandoned",

  @doc("Change apply operation was paused.")
  Paused: "Paused",

  @doc("Change apply operation was failed.")
  Failed: "Failed",

  @doc("Change is not applied to the stage.")
  Skipped: "Skipped",
}

@armResourceOperations
@doc("The operations of the stageProgression resource.")
interface StageProgressions {
  get is ArmResourceRead<StageProgression>;

  createOrUpdate is ArmResourceCreateOrReplaceSync<StageProgression>;
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    StageProgression,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  delete is ArmResourceDeleteSync<StageProgression>;
  deleteAtSubscriptionLevel is ArmResourceDeleteSync<
    StageProgression,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  update is ArmResourcePatchSync<StageProgression, StageProgressionProperties>;
  updateAtSubscriptionLevel is ArmResourcePatchSync<
    StageProgression,
    StageProgressionProperties,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  listByParent is ArmResourceListByParent<StageProgression>;
  listByParentAtSubscriptionLevel is ArmResourceListByParent<
    StageProgression,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
}
