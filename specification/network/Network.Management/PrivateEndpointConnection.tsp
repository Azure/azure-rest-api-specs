import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateLinkService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * PrivateEndpointConnection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(PrivateLinkService)
@Http.Private.includeInapplicableMetadataInPayload(false)
model PrivateEndpointConnection extends SubResourceModel {
  properties?: PrivateEndpointConnectionProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("peConnectionName")
  @segment("privateEndpointConnections")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get the specific private end point connection by specific private link service in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateLinkServices_GetPrivateEndpointConnection")
  getPrivateEndpointConnection is ArmResourceRead<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = Error
  >;

  /**
   * Approve or reject private end point connection for a private link service in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateLinkServices_UpdatePrivateEndpointConnection")
  updatePrivateEndpointConnection is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection>,
    Error = Error
  >;

  /**
   * Delete private end point connection for a private link service in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateLinkServices_DeletePrivateEndpointConnection")
  deletePrivateEndpointConnection is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Gets all private end point connections for a specific private link service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateLinkServices_ListPrivateEndpointConnections")
  listPrivateEndpointConnections is ArmResourceListByParent<
    PrivateEndpointConnection,
    Error = Error
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private end point connection."
);
@@doc(PrivateEndpointConnection.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(PrivateEndpointConnection.properties,
  "Properties of the private end point connection."
);
@@doc(PrivateEndpointConnections.updatePrivateEndpointConnection::parameters.resource,
  "Parameters supplied to approve or reject the private end point connection."
);
