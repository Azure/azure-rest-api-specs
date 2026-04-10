import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateLinkResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * The private endpoint connection resource.
 */
model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the private link. Returns the connection details, status, and configuration for a specific private endpoint.
   */
  get is PrivateEndpointOperations.Read<
    PrivateLinkResource,
    PrivateEndpointConnection
  >;

  /**
   * Update the state of specified private endpoint connection associated with the private link. This operation is typically used to approve or reject pending private endpoint connections.
   */
  createOrUpdate is PrivateEndpointOperations.CreateOrReplaceAsync<
    PrivateLinkResource,
    PrivateEndpointConnection
  >;

  /**
   * Deletes the specified private endpoint connection associated with the private link. This operation will disconnect the private endpoint and remove the connection configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is PrivateEndpointOperations.DeleteAsync<
    PrivateLinkResource,
    PrivateEndpointConnection,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets all private endpoint connections for a private link. Returns the list of private endpoints that are connected or in the process of connecting to this private link.
   */
  list is PrivateEndpointOperations.ListByParent<
    PrivateLinkResource,
    PrivateEndpointConnection
  >;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection resource."
);
