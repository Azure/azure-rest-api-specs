import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
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
    NamePattern = ""
  >;
}

@armResourceOperations
interface RegisteredServers {
  /**
   * Get a given registered server.
   */
  get is ArmResourceRead<RegisteredServer, Error = StorageSyncError>;

  /**
   * Add a new registered server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    RegisteredServer,
    Response = ArmResourceUpdatedResponse<RegisteredServer> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    Error = StorageSyncError
  >;

  /**
   * Update registered server.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    RegisteredServer,
    PatchModel = RegisteredServerUpdateParameters,
    Error = StorageSyncError
  >;

  /**
   * Delete the given registered server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    RegisteredServer,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = StorageSyncError
  >;

  /**
   * Get a given registered server list.
   */
  listByStorageSyncService is ArmResourceListByParent<
    RegisteredServer,
    Response = ArmResponse<RegisteredServerArray>,
    Error = StorageSyncError
  >;

  /**
   * Triggers Server certificate rollover.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegisteredServers_triggerRollover")
  triggerRollover is ArmResourceActionAsync<
    RegisteredServer,
    TriggerRolloverRequest,
    OkResponse,
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
