import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
@doc("A private endpoint connection to an azure resource")
@parentResource(SignalRResource)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the specified private endpoint connection")
  @operationId("SignalRPrivateEndpointConnections_Get")
  get is ArmResourceRead<PrivateEndpointConnection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the state of specified private endpoint connection")
  @operationId("SignalRPrivateEndpointConnections_Update")
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the specified private endpoint connection")
  @operationId("SignalRPrivateEndpointConnections_Delete")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List private endpoint connections")
  @operationId("SignalRPrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.update::parameters.resource,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.update::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The resource of private endpoint and its properties"
);
