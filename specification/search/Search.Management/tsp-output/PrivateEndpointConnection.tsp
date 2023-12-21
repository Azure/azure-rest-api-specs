import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Search;
@doc("Describes an existing Private Endpoint connection to the Azure Cognitive Search service.")
@parentResource(SearchService)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection to the Azure Cognitive Search service with the specified resource group.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the details of the private endpoint connection to the search service in the given resource group.")
  get is ArmResourceRead<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Updates a Private Endpoint connection to the search service in the given resource group.")
  update is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Disconnects the private endpoint connection and deletes it from the search service.")
  delete is ArmResourceDeleteSync<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Gets a list of all private endpoint connections in the given service.")
  listByService is ArmResourceListByParent<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;
}
