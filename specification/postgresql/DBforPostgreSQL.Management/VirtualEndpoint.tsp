import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;
// FIXME: VirtualEndpoint has no properties property
/**
 * Pair of virtual endpoints for a server.
 */
@parentResource(Server)
model VirtualEndpoint
  is Azure.ResourceManager.ProxyResource<VirtualEndpointResourceForPatch> {
  ...ResourceNameParameter<
    Resource = VirtualEndpoint,
    KeyName = "virtualEndpointName",
    SegmentName = "virtualendpoints",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]{0,62}(?<!-)$"
  >;
}

@armResourceOperations
interface VirtualEndpoints {
  /**
   * Gets information about a pair of virtual endpoints.
   */
  get is ArmResourceRead<VirtualEndpoint>;

  /**
   * Creates a pair of virtual endpoints for a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    VirtualEndpoint,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Updates a pair of virtual endpoints for a server.
   */
  @patch(#{ implicitOptionality: false })
  @useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    VirtualEndpoint,
    PatchModel = VirtualEndpointResourceForPatch,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes a pair of virtual endpoints.
   */
  delete is ArmResourceDeleteWithoutOkAsync<VirtualEndpoint>;

  /**
   * Lists pair of virtual endpoints associated to a server.
   */
  listByServer is ArmResourceListByParent<
    VirtualEndpoint,
    Response = ArmResponse<VirtualEndpointsList>
  >;
}

@@maxLength(VirtualEndpoint.name, 63);
@@minLength(VirtualEndpoint.name, 3);
@@doc(VirtualEndpoint.name, "Base name of the virtual endpoints.");
@@doc(VirtualEndpoints.create::parameters.resource,
  "Parameters required to create or update a pair of virtual endpoints."
);
@@doc(VirtualEndpoints.update::parameters.properties,
  "Parameters required to update a pair of virtual endpoints."
);
