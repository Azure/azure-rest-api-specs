import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedHsm.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * Private endpoint connection resource.
 */
@parentResource(ManagedHsm)
model MhsmPrivateEndpointConnection
  is Azure.ResourceManager.TrackedResource<MhsmPrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = MhsmPrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;

  /**
   * Modified whenever there is a change in the state of private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface MhsmPrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the managed HSM Pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MHSMPrivateEndpointConnections_Get")
  get is ArmResourceRead<MhsmPrivateEndpointConnection>;

  /**
   * Updates the specified private endpoint connection associated with the managed hsm pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("MHSMPrivateEndpointConnections_Put")
  put is ArmResourceCreateOrReplaceSync<
    MhsmPrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<MhsmPrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified private endpoint connection associated with the managed hsm pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("MHSMPrivateEndpointConnections_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    MhsmPrivateEndpointConnection,
    Response = ArmResponse<MhsmPrivateEndpointConnection> | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * The List operation gets information about the private endpoint connections associated with the managed HSM Pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MHSMPrivateEndpointConnections_ListByResource")
  listByResource is ArmResourceListByParent<MhsmPrivateEndpointConnection>;
}

@@doc(MhsmPrivateEndpointConnection.name,
  "Name of the private endpoint connection associated with the managed hsm pool."
);
@@doc(MhsmPrivateEndpointConnection.properties, "Resource properties.");
@@doc(MhsmPrivateEndpointConnections.put::parameters.resource,
  "The intended state of private endpoint connection."
);
