import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc(" Response for PrivateEndpoint Connection object")
@parentResource(ElasticSan)
@armResourceInternal(PrivateEndpointConnectionProperties)
@includeInapplicableMetadataInPayload(false)
model PrivateEndpointConnection extends ProxyResourceBase {
  @doc("The name of the Private Endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;

  @doc("Private Endpoint Connection Properties.")
  @extension("x-ms-client-flatten", true)
  properties: PrivateEndpointConnectionProperties;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the Elastic San")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Update the state of specified private endpoint connection associated with the Elastic San")
  create is Template.ArmResourceCreateOrUpdateAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmLroLocationHeader
  >;

  @doc("Deletes the specified private endpoint connection associated with the Elastic San")
  delete is ArmResourceDeleteAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all Private Endpoint Connections associated with the Elastic San.")
  @operationId("PrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnections.create::parameters.parameters,
  "Private Endpoint Connection Approval object."
);
