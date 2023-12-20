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
@doc("The customer's prefix that is registered by the peering service provider.")
@parentResource(Peering)
model PeeringRegisteredPrefix
  is ProxyResource<PeeringRegisteredPrefixProperties> {
  @doc("The name of the registered prefix.")
  @path
  @key("registeredPrefixName")
  @segment("registeredPrefixes")
  name: string;
}

@armResourceOperations
interface PeeringRegisteredPrefixes {
  @doc("Gets an existing registered prefix with the specified name under the given subscription, resource group and peering.")
  get is ArmResourceRead<PeeringRegisteredPrefix>;
  @doc("Creates a new registered prefix with the specified name under the given subscription, resource group and peering.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringRegisteredPrefix>;
  @doc("Deletes an existing registered prefix with the specified name under the given subscription, resource group and peering.")
  delete is ArmResourceDeleteSync<PeeringRegisteredPrefix>;
  @doc("Lists all registered prefixes under the given subscription, resource group and peering.")
  listByPeering is ArmResourceListByParent<PeeringRegisteredPrefix>;
  @doc("Validates an existing registered prefix with the specified name under the given subscription, resource group and peering.")
  validate is ArmResourceActionSync<
    PeeringRegisteredPrefix,
    void,
    PeeringRegisteredPrefix
  >;
}
