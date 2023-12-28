import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("The live event.")
@parentResource(MediaService)
model LiveEvent is TrackedResource<LiveEventProperties> {
  @doc("The name of the live event, maximum length is 32.")
  @maxLength(32)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
  @key("liveEventName")
  @segment("liveEvents")
  name: string;
}

@armResourceOperations
interface LiveEvents {
  @doc("Gets properties of a live event.")
  get is ArmResourceRead<LiveEvent>;
  @doc("Creates a new live event.")
  create is ArmResourceCreateOrUpdateAsync<
    LiveEvent,
    {
      ...BaseParameters<LiveEvent>;

      @doc("The flag indicates if the resource should be automatically started on creation.")
      @query("autoStart")
      autoStart?: boolean;
    }
  >;
  @doc("Updates settings on an existing live event.")
  update is ArmCustomPatchAsync<LiveEvent, LiveEvent>;
  @doc("Deletes a live event.")
  delete is ArmResourceDeleteAsync<LiveEvent>;
  @doc("Lists all the live events in the account.")
  list is ArmResourceListByParent<LiveEvent>;
  @doc("A live event is in StandBy state after allocation completes, and is ready to start.")
  allocate is ArmResourceActionAsync<LiveEvent, void, void>;
  @doc("A live event in Stopped or StandBy state will be in Running state after the start operation completes.")
  start is ArmResourceActionAsync<LiveEvent, void, void>;
  @doc("Stops a running live event.")
  stop is ArmResourceActionAsync<LiveEvent, LiveEventActionInput, void>;
  @doc("Resets an existing live event. All live outputs for the live event are deleted and the live event is stopped and will be started again. All assets used by the live outputs and streaming locators created on these assets are unaffected. ")
  reset is ArmResourceActionAsync<LiveEvent, void, void>;
}
