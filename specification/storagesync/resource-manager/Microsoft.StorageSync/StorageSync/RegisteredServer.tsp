import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Registered Server resource.
 */
@parentResource(StorageSyncService)
model RegisteredServer
  is Azure.ResourceManager.ProxyResource<RegisteredServerProperties> {
  ...ResourceNameParameter<
    Resource = RegisteredServer,
    KeyName = "serverId",
    SegmentName = "registeredServers",
    Type = Azure.Core.uuid,
    NamePattern = ""
  >;
}

@armResourceOperations
interface RegisteredServers {
  /**
   * Get a given registered server.
   */
  get is ArmResourceRead<
    RegisteredServer,
    Response = RegisteredServer & {
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
   * Add a new registered server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @Azure.Core.useFinalStateVia("location")
  create is Legacy.CreateOrReplaceAsync<
    RegisteredServer,
    RegisteredServerCreateParameters,
    Response = (ArmResourceUpdatedResponse<RegisteredServer> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = RegisteredServer> &
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
   * Update registered server.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("location")
  update is ArmCustomPatchAsync<
    RegisteredServer,
    PatchModel = RegisteredServerUpdateParameters,
    Response = (ArmResourceUpdatedResponse<RegisteredServer> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = RegisteredServer> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    })
  >;

  /**
   * Delete the given registered server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    RegisteredServer,
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
    }) | ArmDeletedNoContentResponse,
    Error = StorageSyncError
  >;

  /**
   * Get a given registered server list.
   */
  listByStorageSyncService is ArmResourceListByParent<
    RegisteredServer,
    Response = ArmResponse<RegisteredServerArray> & {
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
   * Triggers Server certificate rollover.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RegisteredServers_triggerRollover")
  triggerRollover is ArmResourceActionSync<
    RegisteredServer,
    TriggerRolloverRequest,
    Response = (OkResponse & {
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

@@doc(RegisteredServer.name, "GUID identifying the on-premises server.");
@@doc(RegisteredServer.properties, "RegisteredServer properties.");
@@doc(RegisteredServers.create::parameters.resource,
  "Body of Registered Server object."
);
@@doc(RegisteredServers.update::parameters.properties,
  "Body of Registered Server object."
);
@@doc(RegisteredServers.triggerRollover::parameters.body,
  "Body of Trigger Rollover request."
);
