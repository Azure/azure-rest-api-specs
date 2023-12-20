import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Batch;
@doc("Contains information about a private link resource.")
@parentResource(BatchAccount)
model BatchPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The private endpoint connection name. This must be unique within the account.")
  @maxLength(101)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-]+\\.?[a-fA-F0-9-]*$")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface BatchPrivateEndpointConnections {
  @doc("Gets information about the specified private endpoint connection.")
  get is ArmResourceRead<BatchPrivateEndpointConnection>;
  @doc("Updates the properties of an existing private endpoint connection.")
  update is ArmResourcePatchAsync<
    BatchPrivateEndpointConnection,
    PrivateEndpointConnectionProperties,
    {
      ...BaseParameters<BatchPrivateEndpointConnection>;

      @doc("The state (ETag) version of the private endpoint connection to update. This value can be omitted or set to \"*\" to apply the operation unconditionally.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes the specified private endpoint connection.")
  delete is ArmResourceDeleteWithoutOkAsync<BatchPrivateEndpointConnection>;
  @doc("Lists all of the private endpoint connections in the specified account.")
  listByBatchAccount is ArmResourceListByParent<
    BatchPrivateEndpointConnection,
    {
      ...BaseParameters<BatchPrivateEndpointConnection>;

      @doc("The maximum number of items to return in the response.")
      @query("maxresults")
      maxresults?: int32;
    }
  >;
}
