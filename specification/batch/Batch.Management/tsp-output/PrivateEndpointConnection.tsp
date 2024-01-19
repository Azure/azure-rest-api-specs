import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
@doc("Contains information about a private link resource.")
@parentResource(BatchAccount)
model PrivateEndpointConnection
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
interface PrivateEndpointConnections {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified private endpoint connection.")
  @operationId("PrivateEndpointConnection_Get")
  get is ArmResourceRead<PrivateEndpointConnection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the properties of an existing private endpoint connection.")
  @operationId("PrivateEndpointConnection_Update")
  update is ArmCustomPatchAsync<
    PrivateEndpointConnection,
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      @doc("The state (ETag) version of the private endpoint connection to update. This value can be omitted or set to \"*\" to apply the operation unconditionally.")
      @header
      `If-Match`?: string;
    },
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the specified private endpoint connection.")
  @operationId("PrivateEndpointConnection_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the private endpoint connections in the specified account.")
  @operationId("PrivateEndpointConnection_ListByBatchAccount")
  listByBatchAccount is ArmResourceListByParent<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      @doc("The maximum number of items to return in the response.")
      @query("maxresults")
      maxresults?: int32;
    }
  >;
}

@@projectedName(PrivateEndpointConnections.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.update::parameters.properties,
  "PrivateEndpointConnection properties that should be updated. Properties that are supplied will be updated, any property not supplied will be unchanged."
);
