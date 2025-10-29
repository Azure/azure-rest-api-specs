import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;
/**
 * Describes an existing private endpoint connection to the Azure AI Search service.
 */
@parentResource(SearchService)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the details of the private endpoint connection to the search service in the given resource group.
   */
  get is ArmResourceRead<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Updates a private endpoint connection to the search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  update is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    },
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection>
  >;

  /**
   * Disconnects the private endpoint connection and deletes it from the search service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteSync<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    },
    Response = ArmResponse<PrivateEndpointConnection>
  >;

  /**
   * Gets a list of all private endpoint connections in the given service.
   */
  listByService is ArmResourceListByParent<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection to the Azure AI Search service with the specified resource group."
);
@@doc(PrivateEndpointConnection.properties,
  "Describes the properties of an existing private endpoint connection to the Azure AI Search service."
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The definition of the private endpoint connection to update."
);
