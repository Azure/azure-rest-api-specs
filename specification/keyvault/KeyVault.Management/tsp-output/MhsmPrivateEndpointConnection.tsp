import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedHsm.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * Private endpoint connection resource.
 */
@parentResource(ManagedHsm)
model MhsmPrivateEndpointConnection
  is TrackedResource<MhsmPrivateEndpointConnectionProperties> {
  /**
   * Name of the private endpoint connection associated with the managed hsm pool.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;

  /**
   * Modified whenever there is a change in the state of private endpoint connection.
   */
  etag?: string;
}

@armResourceOperations
interface MhsmPrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the managed HSM Pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MHSMPrivateEndpointConnections_Get")
  get is ArmResourceRead<MhsmPrivateEndpointConnection>;

  /**
   * Updates the specified private endpoint connection associated with the managed hsm pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MHSMPrivateEndpointConnections_Put")
  put is ArmResourceCreateOrReplaceSync<MhsmPrivateEndpointConnection>;

  /**
   * Deletes the specified private endpoint connection associated with the managed hsm pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MHSMPrivateEndpointConnections_Delete")
  delete is ArmResourceDeleteAsync<MhsmPrivateEndpointConnection>;

  /**
   * The List operation gets information about the private endpoint connections associated with the managed HSM Pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MHSMPrivateEndpointConnections_ListByResource")
  listByResource is ArmResourceListByParent<MhsmPrivateEndpointConnection>;
}

@@projectedName(MhsmPrivateEndpointConnections.put::parameters.resource,
  "json",
  "properties"
);
@@extension(MhsmPrivateEndpointConnections.put::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(MhsmPrivateEndpointConnections.put::parameters.resource,
  "The intended state of private endpoint connection."
);
