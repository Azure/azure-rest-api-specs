import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Full view of network features for an app (presently VNET integration and Hybrid Connections).
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(NetworkFeaturesProperties)
@includeInapplicableMetadataInPayload(false)
model NetworkFeatures extends ProxyOnlyResource {
  /**
   * The type of view. Only "summary" is supported at this time.
   */
  @path
  @key("view")
  @segment("networkFeatures")
  name: string;

  /**
   * NetworkFeatures resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkFeaturesProperties;
}

@armResourceOperations
@projectedName("client", "NetworkFeatures")
interface NetworkFeaturesOperationGroup {
  /**
   * Description for Gets all network features used by the app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListNetworkFeaturesSlot")
  listNetworkFeaturesSlot is ArmResourceRead<NetworkFeatures>;
}
