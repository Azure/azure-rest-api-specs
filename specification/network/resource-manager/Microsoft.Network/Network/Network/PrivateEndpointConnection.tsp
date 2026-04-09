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
using Microsoft.Common;

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
    Microsoft.Common.PrivateEndpointConnection,
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
    Microsoft.Common.PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<Microsoft.Common.PrivateEndpointConnection>,
    Error = Error
  >;

  /**
   * Delete private end point connection for a private link service in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PrivateLinkServices")
  deletePrivateEndpointConnection is ArmResourceDeleteWithoutOkAsync<
    Microsoft.Common.PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Gets all private end point connections for a specific private link service.
   */
  @tag("PrivateLinkServices")
  listPrivateEndpointConnections is ArmResourceListByParent<
    Microsoft.Common.PrivateEndpointConnection,
    Error = Error
  >;
}

@@doc(Microsoft.Common.PrivateEndpointConnection.name,
  "The name of the private end point connection."
);
@@doc(Microsoft.Common.PrivateEndpointConnection.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(Microsoft.Common.PrivateEndpointConnection.properties,
  "Properties of the private end point connection."
);
@@doc(PrivateEndpointConnections.updatePrivateEndpointConnection::parameters.resource,
  "Parameters supplied to approve or reject the private end point connection."
);
