import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LiveEvent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * The Live Output.
 */
@parentResource(LiveEvent)
model LiveOutput is Azure.ResourceManager.ProxyResource<LiveOutputProperties> {
  ...ResourceNameParameter<
    Resource = LiveOutput,
    KeyName = "liveOutputName",
    SegmentName = "liveOutputs",
    NamePattern = "^([a-zA-Z0-9])+(-*[a-zA-Z0-9])*$"
  >;
}

@armResourceOperations
interface LiveOutputOps
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
        Resource = LiveOutput,
        KeyName = "liveOutputName",
        SegmentName = "liveOutputs",
        NamePattern = "^([a-zA-Z0-9])+(-*[a-zA-Z0-9])*$"
      >>
    > {}

@armResourceOperations
interface LiveOutputs {
  /**
   * Gets a live output.
   */
  get is LiveOutputOps.Read<LiveOutput>;

  /**
   * Creates a new live output.
   */
  create is LiveOutputOps.CreateOrUpdateAsync<
    LiveOutput,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a live output. Deleting a live output does not delete the asset the live output is writing to.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is LiveOutputOps.DeleteWithoutOkAsync<
    LiveOutput,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}
@armResourceOperations
interface LiveOutputOperationGroupOps
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
        ...KeysOf<ResourceNameParameter<
          Resource = LiveOutput,
          KeyName = "liveOutputName",
          SegmentName = "liveOutputs",
          NamePattern = "^([a-zA-Z0-9])+(-*[a-zA-Z0-9])*$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = LiveOutput,
        KeyName = "operationId",
        SegmentName = "operationLocations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface LiveOutputOperationGroup {
  /**
   * Get a Live Output operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LiveOutputs_OperationLocation")
  operationLocation is LiveOutputOperationGroupOps.Read<
    LiveOutput,
    Response = ArmResponse<LiveOutput> | AcceptedResponse
  >;

  /**
   * Lists the live outputs of a live event.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LiveOutputs_List")
  list is LiveOutputOperationGroupOps.List<
    LiveOutput,
    Response = ArmResponse<LiveOutputListResult>
  >;
}

@@maxLength(LiveOutput.name, 256);
@@minLength(LiveOutput.name, 1);
@@doc(LiveOutput.name, "The name of the live output.");
@@doc(LiveOutput.properties, "Live output properties.");
@@doc(LiveOutputs.create::parameters.resource,
  "Live Output properties needed for creation."
);
