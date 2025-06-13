import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
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
  get is ArmResourceRead<ServerEndpoint>;

  /**
   * Create a new ServerEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    ServerEndpoint,
    Response = ArmResourceUpdatedResponse<ServerEndpoint> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patch a given ServerEndpoint.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ServerEndpoint,
    PatchModel = ServerEndpointUpdateParameters
  >;

  /**
   * Delete a given ServerEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Get a ServerEndpoint list.
   */
  listBySyncGroup is ArmResourceListByParent<
    ServerEndpoint,
    Response = ArmResponse<ServerEndpointArray>
  >;

  /**
   * Recall a server endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerEndpoints_recallAction")
  recallAction is ArmResourceActionAsync<
    ServerEndpoint,
    RecallActionParameters,
    OkResponse
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
