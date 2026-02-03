import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(Workspace)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.ResourceSkuProperty;

  /**
   * *Same as workspace location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Called by end-users to get a PE connection.
   */
  @summary("Called by end-users to get a PE connection.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Called by end-users to approve or reject a PE connection.
   * This method must validate and forward the call to NRP.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Called by end-users to approve or reject a PE connection.\r\nThis method must validate and forward the call to NRP.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection>
  >;

  /**
   * Called by end-users to delete a PE connection.
   */
  @summary("Called by end-users to delete a PE connection.")
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  /**
   * Called by end-users to get all PE connections.
   */
  @summary("Called by end-users to get all PE connections.")
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionListResult>
  >;
}

@@doc(PrivateEndpointConnection.name, "NRP Private Endpoint Connection Name");
@@doc(PrivateEndpointConnection.properties,
  "Private endpoint connection properties."
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "PrivateEndpointConnection object"
);
@@doc(PrivateEndpointConnection.sku,
  "Optional. This field is required to be implemented by the RP because AML is supporting more than one tier"
);
