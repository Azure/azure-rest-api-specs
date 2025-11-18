import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Private Endpoint Connection ARM resource.
 */
@parentResource(Factory)
model PrivateEndpointConnectionResource
  is Azure.ResourceManager.ProxyResource<RemotePrivateEndpointConnection> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionResource,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface PrivateEndpointConnectionResources {
  /**
   * Gets a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnection_Get")
  get is ArmResourceRead<
    PrivateEndpointConnectionResource,
    Parameters = {
      /**
       * ETag of the private endpoint connection entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PrivateEndpointConnection_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    PrivateEndpointConnectionResource,
    Request = PrivateLinkConnectionApprovalRequestResource,
    Parameters = {
      /**
       * ETag of the private endpoint connection entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnectionResource>
  >;

  /**
   * Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnection_Delete")
  delete is ArmResourceDeleteSync<PrivateEndpointConnectionResource>;

  /**
   * Lists Private endpoint connections
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("privateEndPointConnections_ListByFactory")
  listByFactory is ArmResourceListByParent<
    PrivateEndpointConnectionResource,
    Response = ArmResponse<PrivateEndpointConnectionListResponse>
  >;
}

@@doc(PrivateEndpointConnectionResource.name,
  "The private endpoint connection name."
);
@@doc(PrivateEndpointConnectionResource.properties, "Core resource properties");
@@doc(PrivateEndpointConnectionResources.createOrUpdate::parameters.resource,
  ""
);
