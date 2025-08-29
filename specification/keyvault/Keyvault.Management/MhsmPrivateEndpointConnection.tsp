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
  is Azure.ResourceManager.ProxyResource<MhsmPrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = MhsmPrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;

  /**
   * The supported Azure location where the managed HSM Pool should be created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  /**
   * SKU details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ManagedHsmSku;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Managed service identity
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * Modified whenever there is a change in the state of private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface MhsmPrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the managed HSM Pool.
   */
  get is ArmResourceRead<
    MhsmPrivateEndpointConnection,
    Error = ManagedHsmError
  >;

  /**
   * Updates the specified private endpoint connection associated with the managed hsm pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  put is ArmResourceCreateOrReplaceSync<
    MhsmPrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<MhsmPrivateEndpointConnection>,
    Error = CloudError
  >;

  /**
   * Deletes the specified private endpoint connection associated with the managed hsm pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    MhsmPrivateEndpointConnection,
    Response = ArmResponse<MhsmPrivateEndpointConnection> | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = MhsmPrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * The List operation gets information about the private endpoint connections associated with the managed HSM Pool.
   */
  listByResource is ArmResourceListByParent<
    MhsmPrivateEndpointConnection,
    Response = ArmResponse<MHSMPrivateEndpointConnectionsListResult>,
    Error = ManagedHsmError
  >;
}

@@doc(MhsmPrivateEndpointConnection.name,
  "Name of the private endpoint connection associated with the managed hsm pool."
);
@@doc(MhsmPrivateEndpointConnection.properties, "Resource properties.");
@@doc(MhsmPrivateEndpointConnections.put::parameters.resource,
  "The intended state of private endpoint connection."
);
