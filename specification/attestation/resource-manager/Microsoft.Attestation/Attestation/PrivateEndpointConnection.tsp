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
model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the attestation provider.
   */
  get is PrivateEndpointOperations.Read<
    AttestationProvider,
    Error = CloudError
  >;

  /**
   * Update the state of specified private endpoint connection associated with the attestation provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is PrivateEndpointOperations.CreateOrReplaceSync<
    AttestationProvider,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection>,
    Error = CloudError
  >;

  /**
   * Deletes the specified private endpoint connection associated with the attestation provider.
   */
  delete is PrivateEndpointOperations.DeleteSync<
    AttestationProvider,
    Error = CloudError
  >;

  /**
   * List all the private endpoint connections associated with the attestation provider.
   */
  list is PrivateEndpointOperations.ListByParent<
    AttestationProvider,
    Error = CloudError
  >;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection properties."
);
