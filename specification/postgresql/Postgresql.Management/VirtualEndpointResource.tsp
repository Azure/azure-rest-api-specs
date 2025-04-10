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

namespace Microsoft.DBforPostgreSQL;
// FIXME: VirtualEndpointResource has no properties property
/**
 * Represents a virtual endpoint for a server.
 */
@parentResource(Server)
model VirtualEndpointResource is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = VirtualEndpointResource,
    KeyName = "virtualEndpointName",
    SegmentName = "virtualendpoints",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]{0,62}(?<!-)$"
  >;
}

@armResourceOperations
interface VirtualEndpointResources {
  /**
   * Gets information about a virtual endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualEndpoints_Get")
  get is ArmResourceRead<VirtualEndpointResource>;

  /**
   * Creates a new virtual endpoint for PostgreSQL flexible server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("VirtualEndpoints_Create")
  create is ArmResourceCreateOrReplaceAsync<
    VirtualEndpointResource,
    Response = ArmResourceUpdatedResponse<VirtualEndpointResource> | ArmResourceCreatedResponse<VirtualEndpointResource> | ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing virtual endpoint. The request body can contain one to many of the properties present in the normal virtual endpoint definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("VirtualEndpoints_Update")
  update is ArmCustomPatchAsync<
    VirtualEndpointResource,
    PatchModel = VirtualEndpointResourceForPatch,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a virtual endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualEndpoints_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualEndpointResource>;

  /**
   * List all the servers in a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualEndpoints_ListByServer")
  listByServer is ArmResourceListByParent<VirtualEndpointResource>;
}

@@maxLength(VirtualEndpointResource.name, 63);
@@minLength(VirtualEndpointResource.name, 3);
@@doc(VirtualEndpointResource.name, "The name of the virtual endpoint.");
@@doc(VirtualEndpointResources.create::parameters.resource,
  "The required parameters for creating or updating virtual endpoints."
);
@@doc(VirtualEndpointResources.update::parameters.properties,
  "The required parameters for updating a server."
);
