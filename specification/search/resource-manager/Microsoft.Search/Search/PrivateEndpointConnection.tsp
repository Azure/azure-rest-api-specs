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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  get is ArmResourceRead<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Error = CloudError
  >;

  /**
   * Updates a private endpoint connection to the search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  update is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection>,
    Error = CloudError
  >;

  /**
   * Disconnects the private endpoint connection and deletes it from the search service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  delete is ArmResourceDeleteSync<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Response = ArmResponse<PrivateEndpointConnection> | NotFoundResponse,
    Error = CloudError
  >;

  /**
   * Gets a list of all private endpoint connections in the given service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  listByService is ArmResourceListByParent<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Response = PrivateEndpointConnectionListResult,
    Error = CloudError
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
