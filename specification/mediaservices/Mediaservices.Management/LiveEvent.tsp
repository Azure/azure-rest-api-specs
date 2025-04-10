import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * The live event.
 */
@parentResource(MediaService)
model LiveEvent is Azure.ResourceManager.TrackedResource<LiveEventProperties> {
  ...ResourceNameParameter<
    Resource = LiveEvent,
    KeyName = "liveEventName",
    SegmentName = "liveEvents",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;
}

@armResourceOperations
interface LiveEventOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = MediaService,
          KeyName = "accountName",
          SegmentName = "mediaservices",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = LiveEvent,
        KeyName = "liveEventName",
        SegmentName = "liveEvents",
        NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
      >>
    > {}

@armResourceOperations
interface LiveEvents {
  /**
   * Gets properties of a live event.
   */
  get is LiveEventOps.Read<LiveEvent>;

  /**
   * Creates a new live event.
   */
  create is LiveEventOps.CreateOrUpdateAsync<
    LiveEvent,
    Parameters = {
      /**
       * The flag indicates if the resource should be automatically started on creation.
       */
      @query("autoStart")
      autoStart?: boolean;
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates settings on an existing live event.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is LiveEventOps.CustomPatchAsync<
    LiveEvent,
    PatchModel = LiveEvent,
    Response = ArmResponse<LiveEvent> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: LiveEvent;
    })
  >;

  /**
   * Deletes a live event.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is LiveEventOps.DeleteWithoutOkAsync<
    LiveEvent,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * A live event is in StandBy state after allocation completes, and is ready to start.
   */
  allocate is LiveEventOps.ActionAsync<LiveEvent, void, OkResponse>;

  /**
   * A live event in Stopped or StandBy state will be in Running state after the start operation completes.
   */
  start is LiveEventOps.ActionAsync<LiveEvent, void, OkResponse>;

  /**
   * Stops a running live event.
   */
  stop is LiveEventOps.ActionAsync<LiveEvent, LiveEventActionInput, OkResponse>;

  /**
   * Resets an existing live event. All live outputs for the live event are deleted and the live event is stopped and will be started again. All assets used by the live outputs and streaming locators created on these assets are unaffected.
   */
  reset is LiveEventOps.ActionAsync<LiveEvent, void, OkResponse>;

  /**
   * Gets status telemetry of a live event.
   */
  @action("getStatus")
  listGetStatus is LiveEventOps.ActionAsync<
    LiveEvent,
    void,
    ArmResponse<LiveEventGetStatusResult>
  >;

  /**
   * Get stream events telemetry of a live event.
   */
  @action("getStreamEvents")
  listGetStreamEvents is LiveEventOps.ActionAsync<
    LiveEvent,
    void,
    ArmResponse<LiveEventGetStreamEventsResult>
  >;

  /**
   * Get track ingest heartbeat events telemetry of a live event.
   */
  @action("getTrackIngestHeartbeats")
  listGetTrackIngestHeartbeats is LiveEventOps.ActionAsync<
    LiveEvent,
    void,
    ArmResponse<LiveEventGetTrackIngestHeartbeatsResult>
  >;
}
@armResourceOperations
interface LiveEventOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = MediaService,
          KeyName = "accountName",
          SegmentName = "mediaservices",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = LiveEvent,
          KeyName = "liveEventName",
          SegmentName = "liveEvents",
          NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = LiveEvent,
        KeyName = "operationId",
        SegmentName = "operationLocations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface LiveEventOperationGroup {
  /**
   * Get a live event operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LiveEvents_OperationLocation")
  operationLocation is LiveEventOperationGroupOps.Read<
    LiveEvent,
    Response = ArmResponse<LiveEvent> | AcceptedResponse
  >;

  /**
   * Lists all the live events in the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LiveEvents_List")
  list is LiveEventOperationGroupOps.List<
    LiveEvent,
    Response = ArmResponse<LiveEventListResult>
  >;
}

@@maxLength(LiveEvent.name, 32);
@@minLength(LiveEvent.name, 1);
@@doc(LiveEvent.name, "The name of the live event, maximum length is 32.");
@@doc(LiveEvent.properties, "The live event properties.");
@@doc(LiveEvents.create::parameters.resource,
  "Live event properties needed for creation."
);
@@doc(LiveEvents.update::parameters.properties,
  "Live event properties needed for patch."
);
@@doc(LiveEvents.stop::parameters.body, "LiveEvent stop parameters");
