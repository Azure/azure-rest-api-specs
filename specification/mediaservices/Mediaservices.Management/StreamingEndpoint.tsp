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
 * The streaming endpoint.
 */
@parentResource(MediaService)
model StreamingEndpoint
  is Azure.ResourceManager.TrackedResource<StreamingEndpointProperties> {
  ...ResourceNameParameter<
    Resource = StreamingEndpoint,
    KeyName = "streamingEndpointName",
    SegmentName = "streamingEndpoints",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;

  /**
   * The streaming endpoint sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ArmStreamingEndpointCurrentSku;
}

@armResourceOperations
interface StreamingEndpointOps
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
        Resource = StreamingEndpoint,
        KeyName = "streamingEndpointName",
        SegmentName = "streamingEndpoints",
        NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
      >>
    > {}

@armResourceOperations
interface StreamingEndpoints {
  /**
   * Gets a streaming endpoint.
   */
  get is StreamingEndpointOps.Read<StreamingEndpoint>;

  /**
   * Creates a streaming endpoint.
   */
  create is StreamingEndpointOps.CreateOrUpdateAsync<
    StreamingEndpoint,
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
   * Updates a existing streaming endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is StreamingEndpointOps.CustomPatchAsync<
    StreamingEndpoint,
    PatchModel = StreamingEndpoint,
    Response = ArmResponse<StreamingEndpoint> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: StreamingEndpoint;
    })
  >;

  /**
   * Deletes a streaming endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is StreamingEndpointOps.DeleteWithoutOkAsync<
    StreamingEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List streaming endpoint supported skus.
   */
  @get
  skus is StreamingEndpointOps.ActionSync<
    StreamingEndpoint,
    void,
    ArmResponse<StreamingEndpointSkuInfoListResult>
  >;

  /**
   * Starts an existing streaming endpoint.
   */
  start is StreamingEndpointOps.ActionAsync<
    StreamingEndpoint,
    void,
    OkResponse
  >;

  /**
   * Stops an existing streaming endpoint.
   */
  stop is StreamingEndpointOps.ActionAsync<StreamingEndpoint, void, OkResponse>;

  /**
   * Scales an existing streaming endpoint.
   */
  scale is StreamingEndpointOps.ActionAsync<
    StreamingEndpoint,
    StreamingEntityScaleUnit,
    OkResponse
  >;
}
@armResourceOperations
interface StreamingEndpointOperationGroupOps
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
          Resource = StreamingEndpoint,
          KeyName = "streamingEndpointName",
          SegmentName = "streamingEndpoints",
          NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = StreamingEndpoint,
        KeyName = "operationId",
        SegmentName = "operationLocations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface StreamingEndpointOperationGroup {
  /**
   * Get a streaming endpoint operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StreamingEndpoints_OperationLocation")
  operationLocation is StreamingEndpointOperationGroupOps.Read<
    StreamingEndpoint,
    Response = ArmResponse<StreamingEndpoint> | AcceptedResponse
  >;

  /**
   * Lists the streaming endpoints in the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StreamingEndpoints_List")
  list is StreamingEndpointOperationGroupOps.List<
    StreamingEndpoint,
    Response = ArmResponse<StreamingEndpointListResult>
  >;
}

@@maxLength(StreamingEndpoint.name, 24);
@@minLength(StreamingEndpoint.name, 1);
@@doc(StreamingEndpoint.name,
  "The name of the streaming endpoint, maximum length is 24."
);
@@doc(StreamingEndpoint.properties, "The streaming endpoint properties.");
@@doc(StreamingEndpoints.create::parameters.resource,
  "Streaming endpoint properties needed for creation."
);
@@doc(StreamingEndpoints.update::parameters.properties,
  "Streaming endpoint properties needed for creation."
);
@@doc(StreamingEndpoints.scale::parameters.body,
  "Streaming endpoint scale parameters"
);
