import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * The live event.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MediaService)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(LiveEventProperties)
model LiveEvent extends TrackedResourceBase {
  /**
   * The name of the live event, maximum length is 32.
   */
  @maxLength(32)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
  @path
  @key("liveEventName")
  @segment("liveEvents")
  @visibility("read")
  name: string;

  /**
   * The live event properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LiveEventProperties;
}

@armResourceOperations
interface LiveEvents {
  /**
   * Gets properties of a live event.
   */
  get is ArmResourceRead<LiveEvent>;

  /**
   * Creates a new live event.
   */
  create is ArmResourceCreateOrReplaceAsync<
    LiveEvent,
    {
      ...BaseParameters<LiveEvent>;

      /**
       * The flag indicates if the resource should be automatically started on creation.
       */
      @query("autoStart")
      autoStart?: boolean;
    }
  >;

  /**
   * Updates settings on an existing live event.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<LiveEvent, LiveEvent>;

  /**
   * Deletes a live event.
   */
  delete is ArmResourceDeleteAsync<LiveEvent>;

  /**
   * Lists all the live events in the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LiveEvents_List")
  list is ArmResourceListByParent<LiveEvent>;

  /**
   * A live event is in StandBy state after allocation completes, and is ready to start.
   */
  allocate is ArmResourceActionAsync<LiveEvent, void, void>;

  /**
   * A live event in Stopped or StandBy state will be in Running state after the start operation completes.
   */
  start is ArmResourceActionAsync<LiveEvent, void, void>;

  /**
   * Stops a running live event.
   */
  stop is ArmResourceActionAsync<LiveEvent, LiveEventActionInput, void>;

  /**
   * Resets an existing live event. All live outputs for the live event are deleted and the live event is stopped and will be started again. All assets used by the live outputs and streaming locators created on these assets are unaffected.
   */
  reset is ArmResourceActionAsync<LiveEvent, void, void>;
}

@@projectedName(LiveEvents.create::parameters.resource, "json", "parameters");
@@extension(LiveEvents.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LiveEvents.create::parameters.resource,
  "Live event properties needed for creation."
);
@@projectedName(LiveEvents.update::parameters.properties, "json", "parameters");
@@extension(LiveEvents.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(LiveEvents.update::parameters.properties,
  "Live event properties needed for patch."
);
@@projectedName(LiveEvents.stop::parameters.body, "json", "parameters");
@@extension(LiveEvents.stop::parameters.body, "x-ms-client-name", "parameters");
@@doc(LiveEvents.stop::parameters.body, "LiveEvent stop parameters");
