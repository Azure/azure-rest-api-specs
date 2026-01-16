import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./KubernetesConfigurationPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KubernetesConfiguration;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(KubernetesConfigurationPrivateLinkScope)
model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  get is PrivateEndpointOperations.Read<
    KubernetesConfigurationPrivateLinkScope,
    PrivateEndpointConnection
  >;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is PrivateEndpointOperations.CreateOrReplaceAsync<
    KubernetesConfigurationPrivateLinkScope,
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnection> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Azure.ResourceManager.CommonTypes.PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader>,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  delete is PrivateEndpointOperations.DeleteSync<
    KubernetesConfigurationPrivateLinkScope,
    PrivateEndpointConnection
  >;

  /**
   * Gets all private endpoint connections on a private link scope.
   */
  @action("privateEndpointConnections")
  listByPrivateLinkScope is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection properties."
);
