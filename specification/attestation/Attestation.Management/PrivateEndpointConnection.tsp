import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AttestationProvider.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Attestation;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(AttestationProvider)
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
   * Gets the specified private endpoint connection associated with the attestation provider.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the state of specified private endpoint connection associated with the attestation provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnection>
  >;

  /**
   * Deletes the specified private endpoint connection associated with the attestation provider.
   */
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  /**
   * List all the private endpoint connections associated with the attestation provider.
   */
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionListResultV5>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection associated with the Azure resource"
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection properties."
);
