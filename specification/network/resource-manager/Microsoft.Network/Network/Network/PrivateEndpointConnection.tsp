import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateLinkService.tsp";
import "../Common/PrivateEndpointConnection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface PrivateEndpointConnections {
  /**
   * Get the specific private end point connection by specific private link service in the resource group.
   */
  @tag("PrivateLinkServices")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PrivateLinkServices")
  updatePrivateEndpointConnection is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection>,
    Error = Error
  >;

  /**
   * Delete private end point connection for a private link service in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PrivateLinkServices")
  deletePrivateEndpointConnection is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Gets all private end point connections for a specific private link service.
   */
  @tag("PrivateLinkServices")
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
