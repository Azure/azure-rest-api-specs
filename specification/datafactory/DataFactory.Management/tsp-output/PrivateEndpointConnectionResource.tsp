import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Private Endpoint Connection ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Factory)
@includeInapplicableMetadataInPayload(false)
model PrivateEndpointConnectionResource extends SubResource {
  /**
   * The private endpoint connection name.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;

  /**
   * Core resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: RemotePrivateEndpointConnection;
}

@armResourceOperations
interface PrivateEndpointConnectionResources {
  /**
   * Gets a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnection_Get")
  get is ArmResourceRead<
    PrivateEndpointConnectionResource,
    {
      ...BaseParameters<PrivateEndpointConnectionResource>;

      /**
       * ETag of the private endpoint connection entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnection_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnectionResource,
    {
      ...BaseParameters<PrivateEndpointConnectionResource>;

      /**
       * ETag of the private endpoint connection entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnection_Delete")
  delete is ArmResourceDeleteSync<PrivateEndpointConnectionResource>;

  /**
   * Lists Private endpoint connections
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("privateEndPointConnections_ListByFactory")
  listByFactory is ArmResourceListByParent<PrivateEndpointConnectionResource>;
}

@@projectedName(PrivateEndpointConnectionResources.createOrUpdate::parameters.resource,
  "json",
  "privateEndpointWrapper"
);
@@extension(PrivateEndpointConnectionResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateEndpointWrapper"
);
@@doc(PrivateEndpointConnectionResources.createOrUpdate::parameters.resource,
  ""
);
