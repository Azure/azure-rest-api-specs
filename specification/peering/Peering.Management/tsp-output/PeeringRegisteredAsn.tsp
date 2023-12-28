import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Peering.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Peering;
@doc("The customer's ASN that is registered by the peering service provider.")
@parentResource(Peering)
model PeeringRegisteredAsn is ProxyResource<PeeringRegisteredAsnProperties> {
  @doc("The name of the registered ASN.")
  @key("registeredAsnName")
  @segment("registeredAsns")
  name: string;
}

@armResourceOperations
interface RegisteredAsns {
  @doc("Gets an existing registered ASN with the specified name under the given subscription, resource group and peering.")
  get is ArmResourceRead<PeeringRegisteredAsn>;
  @doc("Creates a new registered ASN with the specified name under the given subscription, resource group and peering.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringRegisteredAsn>;
  @doc("Deletes an existing registered ASN with the specified name under the given subscription, resource group and peering.")
  delete is ArmResourceDeleteSync<PeeringRegisteredAsn>;
  @doc("Lists all registered ASNs under the given subscription, resource group and peering.")
  listByPeering is ArmResourceListByParent<PeeringRegisteredAsn>;
}
