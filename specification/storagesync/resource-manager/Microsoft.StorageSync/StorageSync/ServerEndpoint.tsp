import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Server Endpoint object.
 */
@parentResource(SyncGroup)
model ServerEndpoint
  is Azure.ResourceManager.ProxyResource<ServerEndpointProperties> {
  ...ResourceNameParameter<
    Resource = ServerEndpoint,
    KeyName = "serverEndpointName",
    SegmentName = "serverEndpoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServerEndpoints {
  /**
   * Get a ServerEndpoint.
   */
  get is ArmResourceRead<
    ServerEndpoint,
    Response = ServerEndpoint & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;

  /**
   * Create a new ServerEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @Azure.Core.useFinalStateVia("location")
  create is Legacy.CreateOrReplaceAsync<
    ServerEndpoint,
    ServerEndpointCreateParameters,
    Response = (ArmResourceUpdatedResponse<ServerEndpoint> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ServerEndpoint> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Patch a given ServerEndpoint.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("location")
  update is Legacy.CustomPatchAsync<
    ServerEndpoint,
    PatchModel = ServerEndpointUpdateParameters,
    Response = (ArmResponse<ServerEndpoint> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ServerEndpoint> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError,
    OptionalRequestBody = true
  >;

  /**
   * Delete a given ServerEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerEndpoint,
    Response = (ArmDeletedResponse & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmDeleteAcceptedLroResponse & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Get a ServerEndpoint list.
   */
  listBySyncGroup is ArmResourceListByParent<
    ServerEndpoint,
    Response = ArmResponse<ServerEndpointArray> & {
      @header("Location")
      @doc("Operation Status Location URI")
      location?: string;

      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;

  /**
   * Recall a server endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ServerEndpoints_recallAction")
  recallAction is ArmResourceActionSync<
    ServerEndpoint,
    RecallActionParameters,
    (OkResponse & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;
}

@@doc(ServerEndpoint.name, "Name of Server Endpoint object.");
@@doc(ServerEndpoint.properties, "Server Endpoint properties.");
@@doc(ServerEndpoints.create::parameters.resource,
  "Body of Server Endpoint object."
);
@@doc(ServerEndpoints.update::parameters.properties,
  "Any of the properties applicable in PUT request."
);
@@doc(ServerEndpoints.recallAction::parameters.body,
  "Body of Recall Action object."
);
