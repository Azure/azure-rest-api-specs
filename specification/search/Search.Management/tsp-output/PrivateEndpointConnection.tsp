import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;
/**
 * Describes an existing Private Endpoint connection to the Azure Cognitive Search service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SearchService)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  PrivateEndpointConnectionProperties
)
model PrivateEndpointConnection extends ProxyResourceBase {
  /**
   * The name of the private endpoint connection to the Azure Cognitive Search service with the specified resource group.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;

  /**
   * Describes the properties of an existing Private Endpoint connection to the Azure Cognitive Search service.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointConnectionProperties;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the details of the private endpoint connection to the search service in the given resource group.
   */
  get is ArmResourceRead<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Updates a Private Endpoint connection to the search service in the given resource group.
   */
  update is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Disconnects the private endpoint connection and deletes it from the search service.
   */
  delete is ArmResourceDeleteSync<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Gets a list of all private endpoint connections in the given service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_ListByService")
  listByService is ArmResourceListByParent<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;
}

@@projectedName(PrivateEndpointConnections.update::parameters.resource,
  "json",
  "privateEndpointConnection"
);
@@extension(PrivateEndpointConnections.update::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnection"
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The definition of the private endpoint connection to update."
);
