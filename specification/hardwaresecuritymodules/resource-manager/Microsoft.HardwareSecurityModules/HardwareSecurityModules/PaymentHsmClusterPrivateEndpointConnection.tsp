import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./PaymentHsmCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HardwareSecurityModules;
/**
 * The private endpoint connection resource.
 */
@parentResource(PaymentHsmCluster)
@Versioning.added(Versions.v2025_12_01_preview)
model PaymentHsmClusterPrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PaymentHsmClusterPrivateEndpointConnection,
    KeyName = "peConnectionName",
    SegmentName = "privateEndpointConnections"
  >;

  /**
   * Modified whenever there is a change in the state of private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The private endpoint connection resource exposes an 'etag' for optimistic concurrency control, consistent with the existing CloudHsmCluster private endpoint connection resource."
  etag?: string;
}

@armResourceOperations
@Versioning.added(Versions.v2025_12_01_preview)
interface PaymentHsmClusterPrivateEndpointConnections {
  /**
   * Gets the private endpoint connection for the Payment Hsm Cluster.
   */
  get is ArmResourceRead<PaymentHsmClusterPrivateEndpointConnection>;

  /**
   * Creates or updates the private endpoint connection for the Payment Hsm Cluster.
   */
  create is ArmResourceCreateOrReplaceSync<PaymentHsmClusterPrivateEndpointConnection>;

  /**
   * Deletes the private endpoint connection for the Payment Hsm Cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<PaymentHsmClusterPrivateEndpointConnection>;

  /**
   * The List operation gets information about the private endpoint connections associated with the Payment HSM Cluster
   */
  listByPaymentHsmCluster is ArmResourceListByParent<PaymentHsmClusterPrivateEndpointConnection>;
}

@@maxLength(PaymentHsmClusterPrivateEndpointConnection.name, 24);
@@minLength(PaymentHsmClusterPrivateEndpointConnection.name, 3);
@@doc(
  PaymentHsmClusterPrivateEndpointConnection.name,
  "Name of the private endpoint connection associated with the Payment HSM Cluster."
);
@@doc(
  PaymentHsmClusterPrivateEndpointConnection.properties,
  "Resource properties."
);
@@doc(
  PaymentHsmClusterPrivateEndpointConnections.create::parameters.resource,
  "Parameters of the PrivateEndpointConnection"
);
