import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Full view of network features for an app (presently VNET integration and Hybrid Connections).")
model NetworkFeatures is ProxyResource<NetworkFeaturesProperties> {
  @doc("The type of view. Only \"summary\" is supported at this time.")
  @key("view")
  @segment("networkFeatures")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface NetworkFeatures_WebApps {
  @doc("Description for Gets all network features used by the app (or deployment slot, if specified).")
  listNetworkFeaturesSlot is ArmResourceRead<NetworkFeatures>;
}
